class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.datetime :done_at

      t.timestamps
    end
  end
end
