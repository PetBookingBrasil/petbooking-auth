# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  token         :string           not null
#  device        :integer          not null
#  application   :integer          not null
#  expires_at    :datetime
#  provider      :integer          not null
#  provider_uuid :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
