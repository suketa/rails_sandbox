class CreateAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :assignments do |t|
      t.references :employee, null: false, foreign_key: true, comment: "外部キー：従業員ID"
      t.references :project, null: false, foreign_key: true, comment: "外部キー：プロジェクトID"
      t.string :role, null: false, comment: "役割"

      t.timestamps
    end
    add_index :assignments, [ :employee_id, :project_id ], unique: true
  end
end
