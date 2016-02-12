# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = AdminUser.create(email: 'test@example.com', password: 'testexample', role: 'superuser')
o = Organization.create(name: 'Test')
q = Questionnaire.create(organization: o, title: 'Questionnaire title', mode: 'services')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')