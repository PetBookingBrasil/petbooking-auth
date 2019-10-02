# == Schema Information
#
# Table name: users
#
#  uuid                      :integer          not null, primary key
#  birthday                  :date
#  current_sign_in_at        :datetime
#  sign_in_count             :integer          default(0), not null
#  gender                    :integer
#  avatar                    :string
#  current_sign_in_ip        :string
#  email                     :string(254)
#  last_sign_in_ip           :string
#  phone                     :string(11)
#  name                      :string           not null
#  nickname                  :string
#  reset_password_token      :string
#  encrypted_password        :string           default("")
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  last_sign_in_at           :datetime
#  bitmask                   :integer          default(0), not null
#  http_user_agent           :string(254)
#  avatar_processing         :boolean          default(FALSE), not null
#  cpf                       :string(11)
#  city                      :string
#  state                     :integer
#  search_range              :integer          default(20), not null
#  zipcode                   :string
#  street                    :string
#  street_number             :string
#  password_token_expires_at :datetime
#  neighborhood              :string
#  skype                     :string
#  complement                :string
#  source                    :integer          default(0)
#  validation_code           :integer
#  created_by_business       :integer
#  landline                  :string(11)
#  application_source        :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable

  attr_accessor :current_password, :first_name, :last_name
  attr_accessor :set_by_business, :must_require_phone, :must_require_cpf,
                :must_validate_phone, :must_require_email, :must_require_zipcode, :must_require_password

  validates :search_range, numericality: { greater_than_or_equal_to: 5 }

  validates :name, presence: true, length: { minimum: 2 }
  validates :phone, presence: true, length: { in: (10..11) }, if: :phone_required?
  validates :password, presence: true, confirmation: true, if: :password_required?
  validates :zipcode, :city, :state, :street, :street_number, :neighborhood, presence: true, if: :must_require_zipcode
  validates :birthday, allow_nil: true, inclusion: { in: (150.years.ago..Date.today) }
  validates :source, presence: true
  validates :landline, length: { in: (10..11) }, if: :landline_presence
  validates :landline, presence: true, if: :should_validate_landline?
  validate  :phone_uniqueness, on: :create
  validates :email, presence: true, if: :email_required?
  validates :password, presence: true, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: Devise.password_length, allow_blank: true
  validates :cpf, presence: true, if: :must_require_cpf

  # Email
  #############
  def email_required?
    must_require_email || (!persisted_without_email? && !set_by_business)
  end

  def persisted_without_email?
    persisted? && email_was.blank?
  end

  # Password
  ###########
  def password_required?
    (must_require_password != false) && !must_require_email && email_required? && (!persisted? || password?)
  end

  # Phone
  #############
  def phone_required?
    !skip_phone_validation? &&
    (!must_require_email && email_required? || must_require_phone.to_bool)
  end

  def skip_phone_validation?
    persisted? && (!phone_changed? || persisted_without_phone?)
  end

  def persisted_without_phone?
    persisted? && phone_was.blank?
  end

  def phone_uniqueness
    return true if User.find_by(phone: self.phone.to_i).nil?
    self.errors.add(:error_validation, I18n.t('devise.registrations.phone_uniqueness'))
    false
  end

  # Landline
  #############################

  def should_validate_landline?
    print (phone.blank? && phone_required?)
    phone.blank? && phone_required?
  end

  def landline_presence
    landline.present?
  end

end
