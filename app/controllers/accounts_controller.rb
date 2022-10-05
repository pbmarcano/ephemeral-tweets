class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def destroy
    # queue account deletion 

    # sign out user
    session[:user_id] = nil
    
    # redirect to home screen
    redirect_to root_path
  end
end
