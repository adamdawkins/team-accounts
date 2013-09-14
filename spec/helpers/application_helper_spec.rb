require 'spec_helper'

describe ApplicationHelper do
  describe "#current_user" do
    context "user is logged in" do
      before :each do
        session[:user_id] = FactoryGirl.create(:user).id
      end

      it "returns a User Object" do
        expect(helper.current_user).to be_instance_of User
      end
    end
    
    context "user is not logged in" do
      it "returns nil" do
        expect(helper.current_user).to eq nil
      end
    end

  end
end
