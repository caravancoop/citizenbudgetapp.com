FactoryGirl.define do
  factory :response do
    questionnaire

    initialized_at { Time.now }
    ip { FFaker::Internet.ip }
    assessment { rand(1..100) }
    comments { FFaker::Lorem.words.join(' ') }
    email { FFaker::Internet.email }
    name { FFaker::Lorem.name }
  end

  factory :invalid_response, parent: :response do
    questionnaire nil
    initialized_at nil
    ip nil
  end
end
