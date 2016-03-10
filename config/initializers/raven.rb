if ENV['SENTRY_DSN'].present?
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']

    # Sanitize params sent to sentry
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)

    # Tag events with rails env and server name
    config.tags = { environment: Rails.env, server_name: ENV['SERVER_NAME'] }

    # Remove sentry ready log message upon start
    config.silence_ready = true

    # config.excluded_exceptions = Raven::Configuration::IGNORE_DEFAULT # default
  end
end
