class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors, primary_key: %i[first_name last_name] do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
