class User < ApplicationRecord
  include TwitterClient

  def self.find_or_create_from_auth_hash(hash)
    user = find_or_create_by(provider: hash[:provider], uid: hash[:uid])

    user.update(
      name: hash.info.name,
      profile_image: hash.info.image,
      token: hash.credentials.token,
      secret: hash.credentials.secret
    )

    return user
  end

  def timeline_tweets
    tweet_ids = timeline.map(&:id)
    return twitter.statuses(tweet_ids)
  end

  def timeline
    twitter.user_timeline(id: uid)
  end
end
