FactoryGirl.define do
  factory :admin_user do
    organization

    email { FFaker::Internet.email }
    role { AdminUser::ROLES.sample }
    locale { Locale.available_locales.sample }
  end

  factory :invalid_admin_user, parent: :admin_user do
    email nil
  end
end
