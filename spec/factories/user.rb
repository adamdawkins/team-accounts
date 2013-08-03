FactoryGirl.define do
  factory :user do
    email "adamdawkins@example.com"
    password "password"
    password_confirmation "password"

    trait :invalid do
      password_confirmation "not matching"
    end
  end
end
