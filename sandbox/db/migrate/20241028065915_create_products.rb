class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products, comment: '商品' do |t|
      t.string :name, null: false, comment: '商品名'
      t.decimal :price, precision: 12, scale: 0, null: false, comment: '価格'

      t.timestamps
    end
  end
end
