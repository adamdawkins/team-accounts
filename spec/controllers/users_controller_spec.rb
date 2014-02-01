require 'spec_helper'

describe UsersController do

  describe "GET #new" do
    before :each do
      controller.stub! :authenticate_user
      get 'new'
    end

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
      before :each do 
        controller.stub! :authenticate_user
      end

      it "creates a new user" do 
        expect do
          post :create, user: FactoryGirl.attributes_for(:user)
        end.to change(User, :count).by(1)
      end

      it "re-directs to the new user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(User.last)
      end

      it "does not log the new user in" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(session[:user_id]).to_not eq User.last.id
      end
    end

    context "with invalid attributes" do 
      before :each do 
        controller.stub! :authenticate_user
      end

      it "does not create a user" do 
        expect do
          post :create, user: FactoryGirl.attributes_for(:user, :invalid)
        end.to_not change(User, :count)
      end

      it "re-renders the new template" do
        post :create, user: FactoryGirl.attributes_for(:user, :invalid)
        expect(response).to redirect_to :new_user
      end
    end

  end
end
