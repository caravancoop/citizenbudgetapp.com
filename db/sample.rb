u = AdminUser.create(email: 'test@example.com', password: 'testexample', role: 'superuser')
o = Organization.create(name: 'Test')
q = Questionnaire.create(organization: o, title: 'Questionnaire title', mode: 'services')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
