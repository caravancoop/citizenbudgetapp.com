#
# Usage
#
# 1. Prepare PG database
# rake db:drop
# rake db:create
# rake db:schema:load
#
# 2. Start redis and mongod
#
# 3. rake citizen_budget:migrate_mongodb_to_postgresql
#
# MongoDB configuration: mongoid.yml
# Potsgresql configuration: database.yml

namespace :citizen_budget do
  desc "Import all records from a MongoDB database to a PostgreSQL database"
  task :migrate_mongodb_to_postgresql => :environment do
    Bundler.require(:migrate)

    require 'redis'
    require File.dirname(__FILE__) + '/mongoid.rb'

    redis = Redis.new
    database_name = ActiveRecord::Base.connection.current_database

    ActiveRecord::Base.transaction do

      # AdminUsers without organization
      p "Creating AdminUsers without Organization"
      AdminUser._create_callbacks.instance_variable_set(:@chain, [])

      MongoAdminUser.where(organization_id: nil).all.each do |mongo_admin_user|
        AdminUser.create!(mongo_admin_user.attributes.except(:_id))
      end unless AdminUser.any?

      # Organizations
      p "Creating Organizations: #{MongoOrganization.all.count}"
      MongoOrganization.all.each do |mongo_organization|
        params = mongo_organization.attributes.except(:_id, :locale)
        @organization = Organization.create!(params)

        # AdminUsers
        p "Creating AdminUsers"
        mongo_organization.admin_users.all.each do |mongo_admin_user|
          params = mongo_admin_user.attributes.except(:_id, :organization_id)
          @organization.admin_users.create!(params)
        end

        # Questionnaires
        p "Creating Questionnaires: #{mongo_organization.questionnaires.all.count}"

        # Disable problematic validations
        rejected_validations = [:domain_must_be_active, :domain_must_not_be_blacklisted]
        Questionnaire._validate_callbacks.instance_variable_set(:@chain, Questionnaire._validate_callbacks.instance_variable_get(:@chain).reject {|c| rejected_validations.include?(c.raw_filter)})

        mongo_organization.questionnaires.all.each do |mongo_questionnaire|
          excluded_keys = []
          excluded_keys << mongo_questionnaire.attributes.keys.find {|k| k.match(/{:starts_at=>(.+)}/) }
          excluded_keys << mongo_questionnaire.attributes.keys.select {|k| k.match(/starts_at\(\di\)/) }
          excluded_keys << mongo_questionnaire.attributes.keys.select {|k| k.match(/ends_at\(\di\)/) }

          params = mongo_questionnaire.attributes.except(:_id, :sections, :google_api_authorization, *excluded_keys.flatten)
          @questionnaire = @organization.questionnaires.create!(params)

          # Sections
          p "Creating Sections: #{mongo_questionnaire.sections.all.count}"
          mongo_questionnaire.sections.all.each do |mongo_section|
            params = mongo_section.attributes.except(:_id, :questions)

            # Convert invalid group value, seems like a leftover from the early days
            if params['group'].match(/expense|revenue/)
              params['group'] = 'other'
            end

            @section = @questionnaire.sections.create!(params)

            # Questions
            p "Creating Questions: #{mongo_section.questions.all.count}"
            mongo_section.questions.all.each do |mongo_question|
              params = mongo_question.attributes.except(:_id)
              params['widget_type'] = params.delete('widget') # Rename attribute
              params['options'] = Array.wrap(params['options'])
              params['labels'] = Array.wrap(params['labels'])

              @question = @section.questions.create!(params)
              redis.hset("#{database_name}_questions", mongo_question.id.to_s, @question.id)
            end
          end

          # Responses
          p "Creating Responses: #{mongo_questionnaire.responses.all.count}"
          mongo_questionnaire.responses.all.each do |mongo_response|
            # Seems like some attributes were once used but not anymore
            @response = @questionnaire.responses.create!(mongo_response.attributes.except(:_id, :answers, :postal_code, :age, :gender, :newsletter, :subscribe))
            redis.hset("#{database_name}_responses", mongo_response.id.to_s, @response.id)
          end

          # Google API auth
          if mongo_questionnaire.google_api_authorization.present?
            @questionnaire.create_google_api_authorization!(mongo_questionnaire.google_api_authorization.attributes.except(:_id))
          end
        end
      end unless Organization.any?
    end # transaction


    # Answers
    p "Creating Answers"
    answers = MongoQuestionnaire.all.no_timeout.map do |mongo_questionnaire|
      mongo_questionnaire.responses.all.no_timeout.map do |mongo_response|
        mongo_response.answers.map do |mongo_answer|
          question_id = redis.hget("#{database_name}_questions", mongo_answer[0])
          response_id = redis.hget("#{database_name}_responses", mongo_response.id.to_s)
          value       = mongo_answer[1]

          next unless question_id
          next unless response_id

          if value.is_a?(Array)
            clean = value.map { |v| v.respond_to?(:scrub) ? v.scrub : v }
          elsif value
            clean = value.scrub
          end

          [Array.wrap(clean || value), question_id, response_id]
        end
      end
    end.flatten(2).compact

    p "Total Answers: #{answers.count}"
    Answer.bulk_insert(:value, :question_id, :response_id) do |worker|
      answers.each do |answer|
        worker.add(answer)
      end
    end

  end
end
