class AddLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table(:users) do |t|
      t.string :last_name, index: true
    end
  end
end
