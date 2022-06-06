class ApplicationController < ActionController::Base
  include Pagy::Backend

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    redirect_to root_path
  end

  helper_method :current_user

  def authenticate_user!
    redirect_to home_path unless current_user.present?
  end
end
