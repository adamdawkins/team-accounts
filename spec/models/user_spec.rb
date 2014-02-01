require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  let(:user) { FactoryGirl.build(:user) }

  describe 'basic model' do
    before(:each) do
      user.save!
    end

    it { expect(user).to validate_presence_of                 :email }
    it { expect(user).to validate_uniqueness_of               :email }
    it { expect(user).to allow_value('email@address.com').for :email }
    it { expect(user).to_not allow_value('oeuoe').for         :email }

    it 'saves attributes' do
      result = user.save
      expect(result).to be true
    end

  end

end
