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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
