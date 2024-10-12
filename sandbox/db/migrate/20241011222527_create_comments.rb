class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body, null: false, comment: 'コメント本文'
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
