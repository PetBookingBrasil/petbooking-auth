class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string  :token, null: false
      t.integer :device, null: false
      t.integer :application, null: false
      t.date    :expires_at
      t.integer :provider, null: false
      t.string  :provider_uuid, null: false

      t.timestamps

      t.references :user
    end

    add_index :sessions, :token, unique: true
  end
end
