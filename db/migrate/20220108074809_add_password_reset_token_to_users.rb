class AddPasswordResetTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_reset_token, :string, null: false
    add_column :users, :password_reset_sent_at, :datetime
    add_index :users, :password_reset_token, unique: true
  end
end
