FactoryGirl.define do
  factory :organization do
    name { FFaker::Company.name }
  end

  factory :invalid_organization, parent: :organization do
    name nil
  end
end
