class Users::PasswordsController < ApplicationController
  before_filter :find_user

  def new
  end

  def update
    if @user.update(user_params)
      sign_in :user, @user
      redirect_to root_path, flash: {notice: 'You have successfully set your password'}
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.instance
  end

  def user_params
    params.permit(user: [:password, :password_confirmation])[:user]
  end
end