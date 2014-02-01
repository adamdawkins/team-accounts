require 'spec_helper'

describe SessionsController do

  describe "#new" do

    context "user not logged in" do
      before(:each) do
        get 'new'
      end
      it "returns http success" do
        response.should be_success
      end

      it "renders the new template" do
        expect(response).to render_template "new"
      end

    end

    context "user already logged in" do
      before :each do
        session[:user_id] = 1
        get 'new'
      end

      it "sets a flash message" do
        expect(flash[:notice]).to eq "You are already logged in."
      end

      it "redirects to the homepage" do
        expect(response).to redirect_to root_path
      end

    end
  end

  describe "#create" do
    context "valid user credentials" do

      before :each do
        @user = FactoryGirl.create :user
        post 'create',
             email:    @user.email,
             password: @user.password
      end

      it "creates a user_id session object with the user id" do
        expect(session[:user_id]).to eq @user.id
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets a flash message"  do
        expect(flash[:success]).to eq "You have logged in successfully."
      end

    end

    context "no user with specified email address" do
      before :each do
        post 'create',
             email: 'not-an-existing-email-address@example.com',
             password: 'password'
      end

      it "doesn't create a user_id object in the session" do
        expect(session[:user_id]).to eq nil
      end

      it "re-renders the new page" do
        expect(response).to render_template :new
      end

      it "creates an error message in the flash" do
        expect(flash[:error]).to eq(
          "That email address or password is incorrect."
        )
      end
    end

    context "incorrect. password" do
      before :each do
        @user = FactoryGirl.create :user
        post 'create',
             email:    @user.email,
             password: "#{@user.password}123 "
      end

      it "doesn't create a user_id object in the session" do
        expect(session[:user_id]).to eq nil
      end

      it "re-renders the new page" do
        expect(response).to render_template :new
      end

      it "creates an error message in the flash" do
        expect(flash[:error]).to eq "That email address or password is incorrect."
      end
    end

  end

  describe "#destroy" do
    before :each do
      session[:user_id] = 1
      get 'destroy'
    end

    it "sets the session[:user_id] to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets a flash message" do
      expect(flash[:success]).to eq "You have logged out successfully."
    end

  end

end
