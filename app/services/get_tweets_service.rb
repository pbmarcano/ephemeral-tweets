class GetTweetsService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    get_all_tweets
  end

  private

  attr_reader :user

  delegate :twitter, to: :user

  def get_all_tweets
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true, id: user.uid}
      options[:max_id] = max_id unless max_id.nil?
      twitter.user_timeline(options)
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end
end
