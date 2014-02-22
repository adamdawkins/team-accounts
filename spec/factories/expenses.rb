# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    user_id 1
    date '2014-02-22'
    category_id 1
    amount '9.99'
    description 'MyString'
  end
end
