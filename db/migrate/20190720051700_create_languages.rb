class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.references :developer, polymorphic: true, index: true

      t.timestamps
    end
  end
end
