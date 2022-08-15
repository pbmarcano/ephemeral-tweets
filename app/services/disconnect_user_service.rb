# If we're having trouble auth-ing a Twitter account we'll need to disconnect. 
# If the user revoked their auth keys, ask them to reauthenticate.
# If they deleted their Twitter account, reach out and ask them for next steps.
# If the user is in a trial, just delete their account.

class DisconnectUserService
  def initialize(user:)
    @user = user
  end

  def disconnect
    find_user_on_twitter

    if user.actively_subscribed?
      user.update(connect_to_twitter: false)
      TwitterUnauthorizedCampaign.add(user, restart: true)
    else
      user.destroy
    end
  end

  private

  attr_reader :user

  def find_user_on_twitter
    petes_account.twitter.user(user.uid.to_i)
  rescue Twitter::Error::NotFound
    if user.actively_subscribed?
      user.update(connect_to_twitter: false)
      ErrorMailer.with(user: user).no_twitter_user.deliver_later
    else
      user.destroy
    end
  end

  def petes_account
    User.find_by(uid: "40290771")
  end
end
