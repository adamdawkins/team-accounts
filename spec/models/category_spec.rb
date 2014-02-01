require 'spec_helper'

describe Category do
  it 'has a valid factory' do
    expect(FactoryGirl.create :category).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many :explainations }
  it { should have_many(:transactions).through(:explainations) }
end
