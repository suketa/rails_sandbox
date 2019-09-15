class User < ApplicationRecord
  scope :name1, -> { where("name like 'name1%'") }

  # for MySQL only
  scope :no_optimizer, -> { optimizer_hints("NO_RANGE_OPTIMIZATION(#{table_name})") }
end
