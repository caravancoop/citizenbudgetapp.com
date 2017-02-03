namespace :db do
  desc "Populates the database with a sample Organisation and sample contents"
  task sample: :environment do
    ActiveRecord::Base.transaction do
      o = Organization.create!(name: 'Test')
      u = AdminUser.create!(organization: o, email: 'admin@example.com', password: 'password', role: 'superuser')
      q = Questionnaire.create!(organization: o, title: 'Questionnaire title', mode: 'services')
    end
  end
end
