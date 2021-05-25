# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  provider      :string
#  uid           :string
#  name          :string
#  token         :string
#  secret        :string
#  profile_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
