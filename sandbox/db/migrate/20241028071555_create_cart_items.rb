class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items do |t|
      t.references :product, null: false, foreign_key: true, index: { unique: true }, comment: '商品ID'
      t.integer :quantity, null: false, default: 0, comment: '数量'

      t.timestamps
    end
  end
end
