FactoryGirl.define do
  factory :question do
    section

    # widget { Question::WIDGETS.sample } # Default to random widget

    title { FFaker::Lorem.words.join(' ') }
    description { FFaker::Lorem.paragraph }
    extra { FFaker::Lorem.paragraph }
    embed { FFaker::Lorem.paragraph }
    placeholder { FFaker::Lorem.words.join(' ') }

    unit_name { FFaker::Lorem.word }

    required { FFaker::Boolean.random }
    revenue { FFaker::Boolean.random }
    position { rand(1000) }

    trait :checkbox do
      widget 'checkbox'
    end

    trait :checkboxes do
      widget 'checkboxes'
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
    end

    trait :onoff do
      widget 'onoff'
      unit_amount { rand(100) }
      default_value { rand(1000) }
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
    end

    trait :radio do
      widget 'radio'
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
    end

    trait :option do
      widget 'option'
      unit_amount { rand(100) }
      default_value { rand(1000) }
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
      labels { ['Recreational sports', 'Art classes', 'Educational and business classes', 'Bake sales', 'The Fall Town Fair', 'Book club'].sample(rand(6)) }
    end

    trait :readonly do
      widget 'readonly'
    end

    trait :scaler do
      widget 'scaler'
      unit_amount { rand(100) }
      default_value { rand(1000) }
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
      minimum_units { 0 }
      maximum_units { rand(100) }
      step { rand(2) }
    end

    trait :select do
      widget 'select'
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
    end

    trait :slider do
      widget 'slider'
      unit_amount { rand(100) }
      default_value { rand(1000) }
      options { ['Affogato', 'Americano', 'Babycino', 'Breve', 'Latte', 'Cappuccino', 'Cortado', 'Corretto', 'Espresso', 'Flat White', 'Macchiato'].sample(rand(11)) }
      minimum_units { 0 }
      maximum_units { rand(100) }
      step { rand(2) }
    end

    trait :static do
      widget 'static'
      unit_amount { rand(100) }
    end

    trait :text do
      widget 'text'
      maxlength { rand(1000) }
      size { rand(1000) }
    end

    trait :textarea do
      widget 'textarea'
      rows { rand(10) }
      cols { rand(10) }
    end
  end


  factory :invalid_question, parent: :question do
    title nil
    widget nil
  end
end
