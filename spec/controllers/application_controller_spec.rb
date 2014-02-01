require 'spec_helper'

describe ApplicationController do
  describe '#authenticate_user' do

      controller do
        before_filter :authenticate_user

        def index
          render text: 'index'
        end
      end

    context 'user not logged in' do

      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to login_path
      end
    end

    context 'user logged in' do
      before :each do
        # stub the login
        @user = FactoryGirl.create :user

        session[:user_id] = @user.id

        get :index
      end

      it 'continues through to the action' do
        expect(response.body).to include 'index'
      end
    end
  end

  describe '#login' do
    context 'user not logged in' do

      before :each do
        session[:user_id] = nil
        controller.login 1
      end

      it 'sets session[:user_id] to the passed id' do
        expect(session[:user_id]).to eq 1
      end
    end

    context 'user already logged in' do
      before :each do
        session[:user_id] = 1
      end

      it 'throws an error' do
        proc { controller.login(1) }.should raise_error 'user already logged in'
      end

    end
  end
end
