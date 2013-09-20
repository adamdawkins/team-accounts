# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "category #{n}"
    end
  end
end
