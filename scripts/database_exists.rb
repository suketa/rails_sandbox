ADAPTERS = {
  'postgresql' => :PostgreSQLAdapter,
  'mysql2' => :Mysql2Adapter,
  'sqlite3' => :SQLite3Adapter
}

config = ActiveRecord::Base.configurations[:development]
adapter = ADAPTERS[config['adapter']]
puts ActiveRecord::ConnectionAdapters.const_get(adapter).database_exists?(config)
