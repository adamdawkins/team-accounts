# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :balance do

    sequence :date do |n|
      Date.current.beginning_of_year.since n.days
    end
    amount '100.00'
  end
end
