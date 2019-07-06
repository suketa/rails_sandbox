class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :ip, null: false
      t.integer :aton, limit: 5, default: -> { '(inet_aton(ip))' }

      t.timestamps
    end
  end
end
