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

    describe "amount value validation" do 
      let(:transaction) {FactoryGirl.create(:transaction, amount: 10.00)}

      it "ensures that amount is not greater in value than the remaining unexplained amount on the transaction"

      it "ensures that the amount has the same orientation (credit or debit) as the transaction amount"
      
    end
  end


  describe "#destroy" do
    it "updates the unexplained amount of the transaction" 
  end
end
