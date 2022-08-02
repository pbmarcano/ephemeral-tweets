class HomesController < ApplicationController
  layout "marketing"

  def show
    @social_proof_users = User.last(5).reverse
  end
end
