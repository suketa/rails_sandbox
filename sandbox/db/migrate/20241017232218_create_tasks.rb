class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks, comment: 'タスク' do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.text :description, null: false, comment: '詳細'
      t.date :due_date, comment: '締め切り'
      t.integer :status, null: false, default: 0, comment: '状態：未着手, 進行中, 完了'
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
