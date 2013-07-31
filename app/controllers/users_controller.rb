class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save   
      flash[:notice] = 'Success'
      redirect_to @user
    else
      flash[:error] = 'An error has occured'
    end
  end

  def show

  end
  
  private 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
