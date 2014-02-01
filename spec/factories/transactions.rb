# Read about factories at https://github.com/thoughtbot/factory_girl
#

FactoryGirl.define do
  factory :transaction do
    description 'MyString'
    date '2013-09-11'
    amount 100.00
    payment_method 'MyString'
    reference 'MyString'
    is_credit true

    trait :invalid do
      amount nil
    end

    trait :credit do
      is_credit true
    end

    trait :debit do
      is_credit false
    end
  end
end
