# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  birthday               :date
#  gender                 :integer
#  avatar                 :string
#  phone                  :string
#  nickname               :string
#  cpf                    :string(11)
#  city                   :string
#  state                  :integer
#  search_range           :integer
#  zipcode                :string
#  street                 :string
#  street_number          :string
#  neighborhood           :string
#  skype                  :string
#  complement             :string
#  source                 :integer          default("web")
#  validation_code        :integer
#  created_by_business    :integer
#  landline               :string(11)
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :integer
#

class User < ApplicationRecord
  searchkick word_start: [:name, :cpf, :email, :phone]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GENDERS = [:male, :female]
  ESTADOS = %w[AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR RS SC SE SP TO]
  SOURCE = [:web, :ios, :android, :varejonline]
  PROVIDERS = [:petbooking, :amei, :facebook]

  enum gender: GENDERS
  enum state: ESTADOS
  enum source: SOURCE
  enum provider: PROVIDERS

  has_many :sessions

  validates :search_range, numericality: { greater_than_or_equal_to: 5 }, if: -> { search_range.present? }
  validates :name, presence: true, length: { minimum: 2 }
  validates :phone, presence: true, length: { in: (10..11) }, uniqueness: true, if: -> { phone.present? }
  validates :birthday, allow_nil: true, inclusion: { in: (150.years.ago..Date.today) }
  validates :landline, length: { in: (10..11) }, if: -> { landline.present? }
  validates :email, presence: true, uniqueness: true
  validates :cpf, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def search_data
    attributes.merge(
      'source' => User.sources[source],
      'state' => User.states[state],
      'gender' => User.genders[gender],
    )
  end

  protected

  def password_required?
    if self.provider == 'facebook'
      false
    else
      true
    end
  end
end
