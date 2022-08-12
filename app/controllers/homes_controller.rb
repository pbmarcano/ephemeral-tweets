class HomesController < ApplicationController
  layout "marketing"

  def show
    @social_proof = SocialProof.new
  end
end
