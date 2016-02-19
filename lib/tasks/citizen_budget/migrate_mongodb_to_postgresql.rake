require File.dirname(__FILE__) + '/mongoid.rb'

# Run: rake citizen_budget:migrate_mongodb_to_postgresql
#
# MongoDB configuration: mongoid.yml
# Potsgresql configuration: database.yml
namespace :citizen_budget do
  desc "Import all records from a MongoDB database to a PostgreSQL database"
  task :migrate_mongodb_to_postgresql => :environment do

    @questions_map = {}
    @responses_map = {}

    ActiveRecord::Base.transaction do

      # AdminUsers without organization
      p "Creating AdminUsers without Organization"
      # AdminUser.skip_callback(:create, :after)
      MongoAdminUser.where(organization_id: nil).all.each do |mongo_admin_user|
        AdminUser.create!(mongo_admin_user.attributes.except(:_id))
      end

      # Organizations
      p "Creating Organizations"
      MongoOrganization.all.each do |mongo_organization|
        params = mongo_organization.attributes.except(:_id, :locale)
        @organization = Organization.create!(params)

        # AdminUsers
        p "Creating AdminUsers"
        mongo_organization.admin_users.each do |mongo_admin_user|
          params = mongo_admin_user.attributes.except(:_id, :organization_id)
          @organization.admin_users.create!(params)
        end

        # Questionnaires
        p "Creating Questionnaires"
        MongoQuestionnaire.all.each do |mongo_questionnaire|
          excluded_keys = []
          excluded_keys << mongo_questionnaire.attributes.keys.find {|k| k.match(/{:starts_at=>(.+)}/) }
          excluded_keys << mongo_questionnaire.attributes.keys.select {|k| k.match(/starts_at\(\di\)/) }
          excluded_keys << mongo_questionnaire.attributes.keys.select {|k| k.match(/ends_at\(\di\)/) }

          params = mongo_questionnaire.attributes.except(:_id, :sections, :google_api_authorization, *excluded_keys.flatten)
          @questionnaire = @organization.questionnaires.create!(params)

          # Sections
          mongo_questionnaire.sections.each do |mongo_section|
            params = mongo_section.attributes.except(:_id, :questions)

            # Convert invalid group value, seems like a leftover from the early days
            if params['group'].match(/expense|revenue/)
              params['group'] = 'other'
            end

            @section = @questionnaire.sections.create!(params)

            # Questions
            mongo_section.questions.each do |mongo_question|
              params = mongo_question.attributes.except(:_id)
              @question = @section.questions.create!(params)

              @questions_map[mongo_question.id] = @question.id
            end
          end

          # Responses
          mongo_questionnaire.responses.each do |mongo_response|
            # Seems like some attributes were once used but not anymore
            params = mongo_response.attributes.except(:_id, :answers, :postal_code, :age, :gender, :newsletter, :subscribe)
            @response = @questionnaire.responses.create!(params)
            @responses_map[mongo_response.id] = @response.id
          end

          # Google API auth
          if mongo_questionnaire.google_api_authorization.present?
            params = mongo_questionnaire.google_api_authorization.attributes.except(:_id)
            @questionnaire.create_google_api_authorization!(params)
          end
        end
      end

      # Answers
      p "Creating Answers"
      MongoQuestionnaire.each do |mongo_questionnaire|
        mongo_questionnaire.responses.each do |mongo_response|
          mongo_response.answers.each do |mongo_answer|
            mongo_question_id = mongo_answer[0]
            value = mongo_answer[1]

            question_id = @questions_map[mongo_question_id]
            response_id = @responses_map[mongo_response.id]

            Answer.create!(value: value, question_id: question_id, response_id: response_id)
          end
        end
      end

    end
  end
end
