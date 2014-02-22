require 'spec_helper'

describe Expense do
  it 'has a valid factory' do
    expect(FactoryGirl.build :expense).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :category_id }
    it { should validate_presence_of :date }
    it { should validate_presence_of :description }
    it { should validate_presence_of :amount }
    it { should validate_numericality_of(:amount).is_greater_than 0.00 }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :category }
  end
end
