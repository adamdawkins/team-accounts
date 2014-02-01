require 'spec_helper'

describe Explaination do
  describe 'basic model' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:explaination)).to be_valid
    end

    describe 'basic attribute validation' do

      it { should validate_presence_of :description }
      it { should belong_to :transaction }
      it { should belong_to :category }
      it { should validate_presence_of :transaction }
      it { should validate_presence_of :category }
      it { should validate_presence_of :amount }
      it { should validate_numericality_of(:amount).is_greater_than 0.00 }
    end
  end

  describe 'amount validation' do
    before :all do
      @category = FactoryGirl.create :category
      @transaction = FactoryGirl.create :transaction, amount: 100.00
      2.times do
        FactoryGirl.create :explaination,
                           transaction_id: @transaction.id,
                           category_id: @category.id,
                           amount: 10.00
      end
    end

    it 'is invalid if amount is greater than transaction unexplained amount' do
      expect(
        FactoryGirl.build :explaination,
                          transaction_id: @transaction.id,
                          category_id: @category.id,
                          amount: 90.00
      ).to be_invalid
    end

  end

end
