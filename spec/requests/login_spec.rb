require 'spec_helper'

describe "Login" do

  describe "GET /login" do

    context "user not logged in" do 
      before(:each) do
        visit login_path
      end

      it "has a 200 status code" do
        expect(page.status_code).to be (200)
      end


    end

    context "user logged in" do
      pending "don't know how to write this request spec"
    end
  end

  describe "POST /sessions" do
    context "valid user credentials" do

      before :each do 
        user = FactoryGirl.create :user
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'login'
      end

      it "redirects to the homepage" do
        expect(page.current_path).to eq root_path
      end

    end

  end

end
