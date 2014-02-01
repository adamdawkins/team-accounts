require 'spec_helper'

describe Balance do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:balance)).to be_valid
    end

    let(:balance) { FactoryGirl.build(:balance) }

    describe "validation" do
      it { should validate_presence_of   :date }
      it { should validate_uniqueness_of :date }
      it { should validate_presence_of   :amount }
    end
  end
end
