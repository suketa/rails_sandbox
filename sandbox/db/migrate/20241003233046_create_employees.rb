class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name, null: false, comment: "名前"
      t.integer :age, null: false, comment: "年齢"
      t.references :department, null: false, foreign_key: true, comment: "外部キー：所属部署ID"

      t.timestamps
    end
  end
end
