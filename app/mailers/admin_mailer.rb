# Create a new class to pick up the custom plain-text templates only.
#
# AdminUser is not confirmable or lockable, so we need only define the
# recoverable mailer method.
#
# @see config/initializers/devise.rb
class AdminMailer < Devise::Mailer
  default from: ENV['ACTION_MAILER_FROM']
  default reply_to: ENV['ACTION_MAILER_REPLY_TO']

  def reset_password_instructions(record, token, opts={})
    I18n.with_locale(record.locale) do
      initialize_from_record(record)

      @host = ActionMailer::Base.default_url_options[:host] || I18n.t('app.host')

      if record.organization
        questionnaire = record.organization.questionnaires.last
        if questionnaire && questionnaire.domain?
          @host = questionnaire.domain
        end
      end

      super
    end
  end
end
