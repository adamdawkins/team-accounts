require 'spec_helper'

describe User do

  let(:user) { User.new(email: "adamdawkins@example.com") }

  describe "basic model" do
  
    it { expect(user).to validate_presence_of :email }
    it { expect(user).to validate_uniqueness_of :email }
    it { expect(user).to allow_value('email@address.com').for(:email) }
    it { expect(user).to_not allow_value('oeuoe').for(:email) }

    it "saves attributes" do
      result = user.save
      expect(result).to be true
    end

  end  

end
