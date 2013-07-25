require 'spec_helper'

describe User do

  let(:user) { User.new(email: "adamdawkins@example.com") }

  describe "basic model" do
      
    it "saves attributes" do
      result = user.save
      expect(result).to be true
    end

  end  

end
