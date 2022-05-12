# Preview all emails at http://localhost:3000/rails/mailers/
class TwitterUnauthorizedCampaignPreview < ActionMailer::Preview
  def first
    TwitterUnauthorizedCampaign.first(user)
  end

  def second
    TwitterUnauthorizedCampaign.second(user)
  end

  def third
    TwitterUnauthorizedCampaign.third(user)
  end

  def fourth
    TwitterUnauthorizedCampaign.fourth(user)
  end

  def fifth
    TwitterUnauthorizedCampaign.fifth(user)
  end

  private

  def user
    User.where(id: params[:user_id]).first || User.first || User.new(email: "user@example.com").freeze
  end
end
