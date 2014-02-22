require 'spec_helper'

describe Area do
  it 'has a valid Factory' do
    expect(FactoryGirl.build :area).to be_valid
  end 

  
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

end
