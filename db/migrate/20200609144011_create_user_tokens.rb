class CreateUserTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tokens do |t|
      t.integer :user_id
      t.string :token
      t.datetime :signed_in_at
      t.timestamps
    end
  end
end
