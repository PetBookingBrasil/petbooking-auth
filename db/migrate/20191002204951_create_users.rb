class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id:false do |t|
      t.integer :uuid, null:false, primary_key: true
      t.date :birthday
      t.integer :gender
      t.string :avatar
      t.string :email, limit: 254
      t.string :phone, limit: 11
      t.string :name, null: false
      t.string :nickname
      t.string :password
      t.string :encrypted_password, default: ""
      t.integer :bitmask, null: false, default: 0
      t.string :http_user_agent, limit:254
      t.boolean :avatar_processing, null: false, default: false
      t.string :cpf, limit: 11
      t.string :city
      t.integer :state
      t.integer :search_range, null: false, default: 20
      t.string :zipcode
      t.string :street
      t.string :street_number
      t.datetime :password_token_expires_at
      t.string :neighborhood
      t.string :skype
      t.string :complement
      t.integer :source, default: 0
      t.integer :validation_code
      t.integer :created_by_business
      t.string :landline, limit: 11
      t.integer :application_source

      t.timestamps
    end
  end
end
