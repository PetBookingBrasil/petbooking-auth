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

class Session < ApplicationRecord
  belongs_to :user

  validates :token, :device, :application, :expires_at, :provider, :provider_uuid, presence: true

  before_validation :generate_token, :set_expires_at
  before_validation :get_provider_uuid

  TOKEN_VALID_FOR = 3
  PROVIDERS = [:petbooking, :amei, :facebook]

  enum provider: PROVIDERS

  private

  def set_expires_at
    self.expires_at = DateTime.now + TOKEN_VALID_FOR.days
  end

  def get_provider_uuid
    if self.provider != 'facebook'
      self.provider_uuid = self.user.id
    end
  end

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
