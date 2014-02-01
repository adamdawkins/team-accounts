FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password 'password'
    password_confirmation 'password'

    trait :invalid do
      password_confirmation 'not matching'
    end
  end
end
