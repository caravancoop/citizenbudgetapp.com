FactoryGirl.define do
  factory :widget do
    type { Widget::TYPES.sample }
    options { [] }
    labels { [] }
    unit_amount { nil }
    unit_name { nil }
    default_value { nil }
    size { nil }
    maxlength { nil }
    placeholder { nil }
    rows { nil }
    cols { nil }
  end

  factory :invalid_widget, parent: :widget do
    type nil
  end
end
