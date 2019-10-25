require 'csv'

namespace :users do
  desc "import users from csv"
  task import: :environment do
    CSV.foreach('users.csv', headers: true) do |row|
      @user = User.new(row.to_hash.slice('email', 'password', 'name', 'phone', 'provider', 'birthday', 'gender', 'avatar', 'nickname',
                                         'cpf', 'city', 'state', 'search_range', 'zipcode', 'street', 'street_number', 'neighborhood',
                                         'skype', 'complement', 'source', 'validation_code', 'created_by_business', 'landline', 'remember_created_at'))

      if @user.valid?
        @user.save!
        print '.'
      else
        puts "id: #{row.to_hash['id']} - #{@user.validate!}"
      end
    end
  end
end
