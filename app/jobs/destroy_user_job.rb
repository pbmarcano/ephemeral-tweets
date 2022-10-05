class DestroyUserJob < ApplicationJob
  queue_as :default

  # user gets deleted, then callback comes to update settings
  discard_on ActiveJob::DeserializationError 

  def perform(user)
    user.destroy
  end
end
