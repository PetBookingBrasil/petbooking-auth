# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name,               null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, default: ""
      t.date :birthday
      t.integer :gender
      t.string :avatar
      t.string :phone
      t.string :nickname
      t.string :cpf, limit: 11
      t.string :city
      t.integer :state
      t.integer :search_range
      t.string :zipcode
      t.string :street
      t.string :street_number
      t.string :neighborhood
      t.string :skype
      t.string :complement
      t.integer :source, default: 0
      t.integer :validation_code
      t.integer :created_by_business
      t.string :landline, limit: 11
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :phone,                unique: true
    add_index :users, :cpf,                  unique: true
  end
end
