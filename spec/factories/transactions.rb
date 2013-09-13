# Read about factories at https://github.com/thoughtbot/factory_girl
#

FactoryGirl.define do
  factory :transaction do
    description "MyString"
    date "2013-09-11"
    amount "100.00"
    payment_method "MyString"
    reference "MyString"
  end
end
