class CreateBugChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :bug_children do |t|
      t.bigint :other_id

      t.timestamps
    end
  end
end
