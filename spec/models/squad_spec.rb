require 'spec_helper'

describe Squad do
  it 'has a valid factory' do
    expect(FactoryGirl.build :squad).to be_valid
  end

  describe 'validation' do
    it { should validate_presence_of   :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'associations' do
    it { should have_many :explainations }
  end
end
