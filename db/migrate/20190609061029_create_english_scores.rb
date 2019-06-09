class CreateEnglishScores < ActiveRecord::Migration[6.0]
  def change
    create_table :english_scores do |t|
      t.string :name
      t.integer :reading
      t.integer :writing
      t.integer :speaking
      t.integer :listening
      t.boolean :passed

      t.timestamps
    end
  end
end
