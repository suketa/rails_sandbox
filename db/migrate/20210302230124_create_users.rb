class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :mfa_code_digest
      t.string :name

      t.timestamps
    end
  end
end
