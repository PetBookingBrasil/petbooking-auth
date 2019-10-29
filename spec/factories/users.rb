require 'faker'
# require 'cpf_cnpj'

FactoryBot.define do
  factory :user do
    # Personal information
    name                    { 'Douglas Andre' }
    email                   { 'douglas@petbooking.com.br' }
    birthday                { rand(30.years.ago..20.years.ago).to_date }
    street                  { Faker::Address.street_name }
    street_number           { Faker::Address.building_number }
    city                    { Faker::Address.city }
    state                   { 'PR' }
    cpf                     { '06397826988' }
    phone                   { '41987368933' }
    landline                { '4130140561' }
    gender                  { User::GENDERS.sample }
    nickname                { 'Doug' }
    zipcode                 { '80010100' }
    neighborhood            { 'Centro Cívico' }
    complement              { 'Ap 3002' }
    password                { '123123123' }
    validation_code         {  nil }
    skype                   { 'dougmoura' }
    reset_password_sent_at  { Time.now.utc }
    reset_password_token    { SecureRandom.urlsafe_base64 }
    encrypted_password      { SecureRandom.urlsafe_base64 }

    # Source and Tracking information
    current_sign_in_ip      { Faker::Internet.ip_v4_address }
    current_sign_in_at      { Time.now.utc }
    last_sign_in_ip         { Faker::Internet.ip_v4_address }
    provider                { 'petbooking' }
    source                  { 'web' }
    
    # Search configuration
    search_range            { 5 } 
  end
end