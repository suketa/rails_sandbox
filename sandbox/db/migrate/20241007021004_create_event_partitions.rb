class CreateEventPartitions < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      CREATE TABLE  events1 PARTITION OF events FOR VALUES IN (1);
      CREATE TABLE  events2 PARTITION OF events FOR VALUES IN (2);
    SQL
  end
  def down
    execute <<~SQL
      DROP TABLE IF EXISTS events2;
      DROP TABLE IF EXISTS events1;
    SQL
  end
end
