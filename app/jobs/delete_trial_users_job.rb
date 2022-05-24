class DeleteTrialUsersJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      user.destruct_at_end_of_trial
    end
  end
end
