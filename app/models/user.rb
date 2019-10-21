class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GENDERS = [:male, :female]
  ESTADOS = %w[AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR RS SC SE SP TO]
  SOURCE = [:web, :ios, :android, :varejonline]

  enum gender: GENDERS
  enum state: ESTADOS
  enum source: SOURCE

  protected

  def password_required?
    false
  end
end
