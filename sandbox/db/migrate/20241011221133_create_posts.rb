class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false, comment: 'タイトル'
      t.text :body, null: false, comment: '本文'

      t.timestamps
    end
  end
end
