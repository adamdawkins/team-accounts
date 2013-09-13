require 'spec_helper'

describe Explaination do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:explaination)).to be_valid
    end

    describe "basic attribute validation" do

      it { should validate_presence_of :description }
      it { should belong_to :transaction }
      it { should validate_presence_of :transaction }
      it { should validate_presence_of :amount }
      it { should validate_numericality_of :amount }
    end
  end




  describe "#destroy" do
    it "updates the unexplained amount of the transaction" 
  end
end
