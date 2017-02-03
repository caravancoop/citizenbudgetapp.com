workers Integer(ENV.fetch('WEB_CONCURRENCY') { 2 })
threads 0, Integer(ENV.fetch('MAX_THREADS') { 5 })

rackup      DefaultRackup
port        3000
environment ENV.fetch('RACK_ENV') { 'development' }

preload_app!

on_worker_boot do
  # Reconnect to database
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection

  # Sidekiq doesn't create connections until you try to do something https://github.com/mperham/sidekiq/issues/627#issuecomment-20366059
end
