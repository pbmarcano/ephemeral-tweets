class SocialProof
  def users
    ids = Rails.cache.fetch("social_proof_users", expires_in: 12.hours) do 
      User.enabled_sweeping.last(5).reverse.pluck(:id)
    end

    User.where(id: ids).to_a
  end
end
