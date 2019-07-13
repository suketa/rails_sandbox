class CreateUser < ActiveRecord::Migration[6.0]
  def up
    create_table :users, if_not_exists: true do |t|
      t.string :name
    end
  end

  def down
    drop_table :users, if_exists: true
  end

  # def change
  #   create_table :users, if_not_exists: true, if_exists: true do |t|
  #     t.string :name
  #   end
  # end
end
