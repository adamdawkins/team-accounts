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
    end
  end

end
