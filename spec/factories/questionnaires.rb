FactoryGirl.define do
  factory :questionnaire do
    organization

    # Basic
    title { FFaker::Lorem.words.join(' ') }
    locale { Locale.available_locales.sample }
    starts_at { Time.now }
    ends_at { starts_at + 6.months }
    time_zone { ActiveSupport::TimeZone.all.map(&:name).sample }
    domain { FFaker::Internet.domain_name }
    email_required { FFaker::Boolean.random }

    # Mode
    mode { Questionnaire::MODES.sample }

    starting_balance { rand(10) }
    maximum_deviation { rand(10) }
    # default_assessment { rand(1000) }
    assessment_period { Questionnaire::ASSESSMENT_PERIODS.sample }
    # tax_rate { rand(0.1) }
    tax_revenue { rand(1000) }
    change_required { FFaker::Boolean.random }

    # Apperance
    # logo
    # title_image
    logo_width { rand(100) }
    logo_height { rand(100) }
    title_image_width { rand(100) }
    title_image_height { rand(100) }
    introduction { FFaker::Lorem.paragraphs.join(' ') }
    instructions { FFaker::Lorem.sentences.join(' ') }
    read_more { FFaker::Lorem.sentence }
    content_before { FFaker::Lorem.sentence }
    content_after { FFaker::Lorem.sentence }
    description { FFaker::Lorem.sentence }
    attribution { FFaker::Lorem.sentence }
    stylesheet ".something { color: blue; }"
    javascript "console.log('coffee')"

    # Thank you email
    reply_to { FFaker::Internet.email }
    thank_you_subject { FFaker::Lorem.sentence }
    thank_you_template { FFaker::Lorem.paragraph }

    # Personal page
    response_notice { FFaker::Lorem.sentence }
    response_preamble { FFaker::Lorem.sentence }
    response_body { FFaker::Lorem.sentence }

    # Third-party integration
    google_analytics { FFaker::Lorem.characters(15) }
    google_analytics_profile { FFaker::Lorem.characters(9) }
    twitter_screen_name { FFaker::Lorem.characters(10) }
    twitter_text { FFaker::Lorem.sentence }
    twitter_share_text { FFaker::Lorem.sentence }
    facebook_app_id { FFaker::Lorem.characters(15) }
    open_graph_title { FFaker::Lorem.sentence }
    open_graph_description { FFaker::Lorem.sentence }

    authorization_token { FFaker::Lorem.characters(15) }


    trait :services do
      mode 'services'
      tax_revenue { rand(1000) }
      tax_rate { rand(0.1) }
    end

    trait :taxes do
      mode 'taxes'
      default_assessment { rand(1000) }
      tax_rate { rand(0.1) }
    end
  end

  factory :invalid_questionnaire, parent: :questionnaire do
    title nil
    mode nil
  end
end
