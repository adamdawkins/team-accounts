# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :explaination do
    description "MyString"
    amount "9.99"
    transaction_id 1
  end
end
