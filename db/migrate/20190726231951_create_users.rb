class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :profile0
      t.text :profile1, limit: 255
      t.text :profile2, limit: 16777215
      t.text :profile3 # , limit: 4294967295
      t.text :profile4, size: :tiny
      t.text :profile5, size: :medium
      t.text :profile6, size: :long

      t.timestamps
    end
  end
end
