module Trial
  extend ActiveSupport::Concern

  def destruct_at_end_of_trial
    self.destroy if ready_for_deletion?
  end

  def trial_expires_at
    created_at + 7.days
  end

  private

  def ready_for_deletion?
    !actively_subscribed? && trial_expired?
  end

  def trial_expired?
    created_at < 7.days.ago
  end
end
