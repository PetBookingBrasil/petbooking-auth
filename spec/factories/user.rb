require 'faker'
require 'cpf_cnpj'

FactoryBot.define do
  factory :user do
    birthday                  { rand(30.years.ago..20.years.ago).to_date }
    current_sign_in_ip        { Faker::Internet.ip_v4_address }
    current_sign_in_at        { Time.now.utc }
    gender                    { User::GENDERS.sample }
    zipcode                   { '80010-100' }
    street                    { Faker::Address.street_name }
    street_number             { Faker::Address.building_number }
    city                      { Faker::Address.city }
    state                     { User::ESTADOS.sample }
    cpf                       { CPF.generate }
    last_sign_in_ip           { Faker::Internet.ip_v4_address }
    sequence(:name)           { |n| "User #{n}" }
    nickname                  { (name || '').split()[0] }
    password                  { Faker::Internet.password }
    phone                     { Faker::PhoneNumber.cell_phone }
    remember_created_at       { Time.now.utc }
    reset_password_sent_at    { Time.now.utc }
    reset_password_token      { SecureRandom.urlsafe_base64 }
    neighborhood              { Faker::Address.state }
    bitmask                   { 7 } # accepts all notifications
    source                    { 'web' }
    landline                  { Faker::Number.number(digits = 11) }
    validation_code           { nil }

    sequence(:email) { |n| Faker::Internet.email.gsub('@', "#{n}@") }

    trait :without_nickname do
      name { 'Foo Bar' }
      nickname { nil }
    end

    trait :without_password do
      encrypted_password  { nil }
    end
  end
end
