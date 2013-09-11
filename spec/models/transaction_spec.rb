require 'spec_helper'

describe Transaction do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:transaction)).to be_valid
    end

    let(:transaction) {FactoryGirl.build(:transaction)}

    describe "validation" do
      before(:each) do 
        transaction.save!
      end

      it { expect(transaction).to validate_presence_of :date }
      it { expect(transaction).to validate_presence_of :description }
      it { expect(transaction).to validate_presence_of :amount }
      it { expect(transaction).to validate_numericality_of :amount }
    end

    it "saves attributes" do
      result = transaction.save
      expect(result).to be true
    end

    it "has many explainations" do
      expect(transaction).to have_many :explainations
    end

    describe "#destroy" do
      it "deletes dependent explainations"
    end
  end
end
