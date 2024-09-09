class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
