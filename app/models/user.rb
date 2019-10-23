class User < ApplicationRecord
  searchkick word_start: [:name, :cpf, :email, :phone]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GENDERS = [:male, :female]
  ESTADOS = %w[AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR RS SC SE SP TO]
  SOURCE = [:web, :ios, :android, :varejonline]

  enum gender: GENDERS
  enum state: ESTADOS
  enum source: SOURCE

  def search_data
    attributes.merge(
      "source" => self.source.to_i
    )
  end

  protected

  def password_required?
    false
  end
end
