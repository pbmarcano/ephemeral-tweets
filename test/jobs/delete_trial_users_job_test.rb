require "test_helper"

class DeleteTrialUsersJobTest < ActiveJob::TestCase
  test "deletes unsubscribed users" do
    @subscribed_user = users(:one)
    @unsubscribed_user = users(:two)
    @unsubscribed_user.update(created_at: 10.days.ago)

    DeleteTrialUsersJob.perform_now

    all_users = User.all

    assert all_users.include?(@subscribed_user)
    assert all_users.exclude?(@unsubscribed_user)
  end
end
