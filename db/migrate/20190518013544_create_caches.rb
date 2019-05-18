class CreateCaches < ActiveRecord::Migration[6.0]
  def change
    create_table :caches do |t|
      t.string :name

      t.timestamps
    end
  end
end
