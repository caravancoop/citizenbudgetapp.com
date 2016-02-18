FactoryGirl.define do
  factory :section do
    questionnaire

    title { ['Cultural Centers & Arenas', 'Roads & Snow Removal', 'Garbage Removal', 'Core City Services', 'Revenue Generating Projects', 'Submit your choices'].sample }
    group { [:simulator, :custom, :other].sample }
    description { FFaker::Lorem.sentences(2) }
    extra { FFaker::Lorem.sentences(2) }
    embed { FFaker::Lorem.paragraph }
  end

  factory :invalid_section, parent: :section do
    title nil
    group nil
  end
end
