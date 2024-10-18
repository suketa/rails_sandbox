class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories, comment: 'カテゴリ' do |t|
      t.string :name, null: false, comment: 'カテゴリ名'

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
