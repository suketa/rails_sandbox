class CreateDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :departments do |t|
      t.string :name, null: false, comment: "部署名" # ユニーク制約つけてもいいかも

      t.timestamps
    end
  end
end
