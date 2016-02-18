FactoryGirl.define do
  factory :answer do
    value { [rand(10), String.new, Array.new].sample }
  end

  factory :invalid_answer, parent: :answer do
    value nil
  end
end
