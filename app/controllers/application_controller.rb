class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :bounce_anonymous

  helper_method :render_to_string, :page_param

  private

  def self.member_actions(*extras)
    [:show, :edit, :update, :destroy] + extras
  end

  def self.collection_actions(*extras)
    [:index, :new, :create] + extras
  end  

  def id_param
    params.permit(:id)[:id]
  end  

  def sort_param
    params.permit(:sort)[:sort]
  end

  def page_param
    params.permit(:page)[:page]
  end

  def bounce_anonymous
    if !(controller?('users/passwords', 'users/sessions') || action?('rss')) && !user_signed_in?
      if User.instance.encrypted_password.blank?
        redirect_to(new_users_password_path) and return
      else
        redirect_to(new_users_session_path) and return
      end
    end
  end
end
