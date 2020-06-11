# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email,              null: false
      t.string :encrypted_password, null: false, default: ""
      t.boolean :active, default: true
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
  end
end
