class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def destroy
    if safe_to_delete_user?
      DestroyUserJob.perform_later(current_user)

      session[:user_id] = nil # sign out

      redirect_to root_path
    else
      redirect_to account_path
    end

  end

  private

  def safe_to_delete_user?
    if current_user.actively_subscribed?
      return current_user.cancelled?
    else
      return true
    end
  end
end
