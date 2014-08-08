class Users::SessionsController < ApplicationController
  before_filter :find_user

  def new ; end  

  def create
    if @user.valid_password?(user_params.try(:[], :password))
      sign_in(:user, @user)
      redirect_to root_path, flash: {notice: 'You have been logged in successfully'}
    else
      flash.now[:warning] = 'Password is invalid'
      render :new
    end
  end

  private

  def find_user
    @user = User.instance
  end

  def user_params
    params.permit(user: [:password])[:user]
  end  
end