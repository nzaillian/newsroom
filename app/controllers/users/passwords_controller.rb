class Users::PasswordsController < ApplicationController
  before_filter :find_user

  before_filter :bounce_if_password_set

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

  def bounce_if_password_set
    if @user.encrypted_password.present?
      redirect_to(root_path) and return
    end
  end
end