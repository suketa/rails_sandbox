class AddIndexLowerNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, 'lower(name)', name: 'index_lower_name'
    add_index :users, 'name', name: 'index_name'
  end
end
