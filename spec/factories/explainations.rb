# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :explaination do
    description "MyString"
    amount 1.00
    association :transaction, factory: :transaction
  end
end
