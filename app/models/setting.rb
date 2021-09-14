class Setting < ApplicationRecord
  belongs_to :user

  def disable_sweeping
    self.update(sweeping: false)
  end
end
