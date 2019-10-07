require 'faker'

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
    cpf                       { User::CPF.generate }
    last_sign_in_ip           { Faker::Internet.ip_v4_address }
    sequence(:name)           { |n| "User #{n}" }
    nickname                  { (name || '').split()[0] }
    password                  { Faker::Internet.password }
    phone                     { Faker::PhoneNumber.cell_phone }
    remember_created_at       { Time.now.utc }
    reset_password_sent_at    { Time.now.utc }
    reset_password_token      { SecureRandom.urlsafe_base64 }
    reset_password_sent_at_v2 { Time.now.utc }
    reset_password_token_v2   { SecureRandom.urlsafe_base64 }
    neighborhood              { Faker::Address.state }
    device_token              { '' }
    device_arn                { 'arn:aws:sns:us-east-1:959198832153:endpoint/APNS_SANDBOX/PetBooking/d4aaccfb-88f6-3e4b-aa33-f2f77cfbf591' }
    bitmask                   { 7 } # accepts all notifications
    source                    { 'web' }
    landline                  { Faker::PhoneNumber.cell_phone }
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
