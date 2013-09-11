require 'spec_helper'

describe Explaination do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:explaination)).to be_valid
    end

    let(:explaination) {FactoryGirl.build(:explaination)}

    describe "basic attribute validation" do

      before(:each) do 
        explaination.save!
      end

      it { expect(explaination).to validate_presence_of :description }
      it { expect(explaination).to belong_to :transaction }
      it { expect(explaination).to validate_presence_of :amount }
      it { expect(explaination).to validate_numericality_of :amount }
    end

    it "saves attributes" do
      result = explaination.save
      expect(result).to be true
    end

    describe "#validate" do
      pending "write the custom validation method to meet these critera"

    describe "amount value validation" do 

      let(:transaction) {
        FactoryGirl.create(
          :transaction_with_explainations,
           amount: 100.00,
           explainations_amount: 10.00,
           explainations_count: 1) 
      }

      let(:valid_explaination) {
        FactoryGirl.build(
        :explaination,
         amount: 70.00,
         transaction_id: transaction.id)
      }

      let(:invalid_explaination) {
        FactoryGirl.build(
        :explaination,
         amount: 90.00,
         transaction_id: transaction.id)
      }

      it "ensures that amount is not greater in value than the remaining unexplained amount on the transaction" do
        pending "these are examples of the validation method acceptance criteria"
        #expect(valid_explaination).to be_valid
        #expect(invalid_explaination).to_not be_valid
      end

      it "ensures that the amount has the same orientation (credit or debit) as the transaction amount"
      
    end
    end
  end


  describe "#destroy" do
    it "updates the unexplained amount of the transaction" 
  end
end
