module TwitterClient
  extend ActiveSupport::Concern

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
