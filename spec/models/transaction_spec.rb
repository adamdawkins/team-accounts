require 'spec_helper'

describe Transaction do
  it "has a valid factory" do
    expect(FactoryGirl.create(:transaction)).to be_valid
  end

  let(:transaction) {FactoryGirl.build(:transaction)}

  describe "basic model" do
    before(:each) do 
      transaction.save!
    end

    it { expect(transaction).to validate_presence_of :date }
    it { expect(transaction).to validate_presence_of :description }
    it { expect(transaction).to validate_presence_of :amount }
    it { expect(transaction).to validate_numericality_of :amount }

  end

end
