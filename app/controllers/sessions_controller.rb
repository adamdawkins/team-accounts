class SessionsController < ApplicationController

  def new
    if !session[:user_id].nil?
      flash[:notice] = "You are already logged in."
      redirect_to root_path
    end
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      login user.id
      flash[:notice] = "You have logged in successfully."
      redirect_to root_path
    else
      flash[:alert] = "That email address or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully."
    redirect_to root_path
  end

end
