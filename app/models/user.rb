# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  provider      :string
#  uid           :string
#  username      :string
#  token         :string
#  secret        :string
#  profile_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  include TwitterClient

  has_many :tweets

  def self.find_or_create_from_auth_hash(hash)
    user = find_or_create_by(provider: hash[:provider], uid: hash[:uid])

    user.update(
      username: hash.info.nickname,
      profile_image: hash.info.image,
      token: hash.credentials.token,
      secret: hash.credentials.secret
    )

    return user
  end

  def timeline
    twitter.user_timeline(id: uid)
  end
end
