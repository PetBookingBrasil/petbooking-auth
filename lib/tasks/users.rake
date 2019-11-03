require 'csv'

namespace :users do
  desc "import users from csv"
  task import: :environment do
    CSV.foreach('users.csv', headers: true) do |row|
      @user = user_find_or_initialize_by(row.to_hash)

      unless @user.persisted?
        if @user.save(validate: false)
          print '.'
        else
          puts "id: #{row.to_hash['id']} - #{@user.validate!}"
        end
      end
    end
  end

  desc "import sessions from csv" do
    CSV.foreach('identities.csv', headers: true) do |row|
      params = row.to_hash
      @user = User.find(params['user_id'])
      @user.sessions.create(application: 'petbooking', device: 'web', provider: params['provider'], provider_uuid: params['uid']) if @user.present?
    end
  end

  def user_find_or_initialize_by(params)
    user = User.find_by(email: params['email']) || User.find_by(cpf: params['cpf']) || User.find_by(phone: params['phone'])
    return user if user.try(:persisted?)
    user = User.new(params.slice('email', 'password', 'name', 'phone', 'provider', 'birthday', 'avatar', 'nickname',
                                  'cpf', 'city', 'search_range', 'zipcode', 'street', 'street_number', 'neighborhood',
                                  'skype', 'complement', 'validation_code', 'created_by_business', 'landline', 'remember_created_at'))
    user.source = User::SOURCE[params['source'].to_i]
    user.state = User::ESTADOS[params['state'].to_i]
    user.gender = User::GENDERS[params['gender'].to_i]
    user
  end
end
