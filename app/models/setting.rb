# == Schema Information
#
# Table name: settings
#
#  id                    :bigint           not null, primary key
#  sweeping              :boolean          default(FALSE)
#  time_threshold        :integer          default(365)
#  upcoming_notification :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint           not null
#
# Indexes
#
#  index_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Setting < ApplicationRecord
  belongs_to :user

  def disable_sweeping
    self.update(sweeping: false)
  end
end
