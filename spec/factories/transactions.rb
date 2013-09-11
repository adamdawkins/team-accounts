# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    description "MyString"
    date "2013-09-11"
    amount "10.00"
    payment_method "MyString"
    reference "MyString"

    factory :transaction_with_explainations do
      ignore do
        explainations_count 2
        explainations_amount 1.00
      end

      after(:create) do |transaction, evaluator|
        FactoryGirl.create_list(:explaination, evaluator.explainations_count, transaction: transaction, amount: evaluator.explainations_amount)
      end

    end
     
  end
end
