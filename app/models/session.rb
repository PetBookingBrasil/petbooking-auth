class Session < ApplicationRecord
  belongs_to :user

  validates :token, :device, :application, :expires_at, :provider, :provider_uuid, presence: true

  before_validation :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
