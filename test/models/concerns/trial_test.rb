require "test_helper"

class TrialTest < ActiveJob::TestCase
  setup do
    @subscribed_user = users(:one)
    @unsubscribed_user = users(:two)
  end

  test "subscribed user doesn't get deleted" do
    @subscribed_user.destruct_at_end_of_trial
    assert User.all.include?(@subscribed_user)
  end

  test "subscribed user at end of trial period doesn't get deleted" do
    @subscribed_user.update(created_at: 100.days.ago)
    @subscribed_user.destruct_at_end_of_trial
    assert User.all.include?(@subscribed_user)
  end

  test "unsubscribed user gets deleted at end of trial" do
    @unsubscribed_user.update(created_at: 8.days.ago)
    @unsubscribed_user.destruct_at_end_of_trial
    assert User.all.exclude?(@unsubscribed_user)
  end

  test "unsubscribed user doesn't get delete if in a trial" do
    @unsubscribed_user.update(created_at: 3.days.ago)
    @unsubscribed_user.destruct_at_end_of_trial
    assert User.all.include?(@unsubscribed_user)
  end
end
