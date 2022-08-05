class HomesController < ApplicationController
  layout "marketing"

  def show
    @social_proof_users = sweeping_users
  end

  private

  def sweeping_users
    User.enabled_sweeping.last(5).reverse
  end
end
