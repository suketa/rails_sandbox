class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: false, options: "PARTITION BY LIST (account_id)" do |t|
      t.bigint :account_id, null: false
      t.integer :kind, null: false
      t.timestamp :occurred_at, null: false

      t.timestamps
    end
  end
end
