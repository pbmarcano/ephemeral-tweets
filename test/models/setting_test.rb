# == Schema Information
#
# Table name: settings
#
#  id                    :bigint           not null, primary key
#  sweeping              :boolean          default(FALSE)
#  time_threshold        :integer          default(365)
#  upcoming_notification :boolean          default(TRUE)
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
require "test_helper"

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
