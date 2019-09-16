class CreateEmperors < ActiveRecord::Migration[6.0]
  def change
    create_table :emperors do |t|
      t.string :name
      t.datetime :enthroned_at

      t.timestamps
    end
  end
end
