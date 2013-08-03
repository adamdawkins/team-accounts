require 'spec_helper'

describe UsersController do

  describe "GET #new" do
    before { get :new }
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "assigns @user to a new User object" do
      expect(assigns[:user].class.name).to eq "User"
    end 

    it "renders the new template" do
      expect(response).to render_template "new" 
    end
  end

  describe "POST #create" do 
    
    context "with valid attributes" do
      it "creates a new user" do 
        expect {
          post :create, user: {email: "adamdawkins@gmail.com", password: "password", password_confirmation: "password"}
        }.to change(User, :count).by(1)
      end

      it "re-directs to the new user" do
          post :create, user: {email: "adamdawkins@gmail.com", password: "password", password_confirmation: "password"}
          expect(response).to redirect_to(User.last)
      end
    end
    
  end

end
