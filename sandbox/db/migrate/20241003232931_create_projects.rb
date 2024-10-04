class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false, comment: "プロジェクト名"
      t.date :start_date, null: false, comment: "開始日"

      t.timestamps
    end
  end
end
