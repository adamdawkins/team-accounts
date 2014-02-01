require 'spec_helper'

describe "Login" do

  describe "GET /login" do

    context "user not logged in" do 
      before :all do
        visit login_path
      end

      it "has a 200 status code" do
        expect(page.status_code).to be (200)
      end

    end

    context "user logged in" do
      before :each do
        mock_login
        visit login_path
      end
      
      it "redirects to the root path" do
        expect(page.current_path).to eq root_path
      end

      it "displays a message to the user" do
        expect(page).to have_content "You are already logged in"
      end

    end
  end

  describe "POST /sessions" do
    context "valid user credentials" do

      before :all do 
        mock_login
      end

      it "redirects to the homepage" do
        expect(page.current_path).to eq root_path
      end

    end

  end

end
