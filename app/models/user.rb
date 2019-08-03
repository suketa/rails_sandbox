class User < ApplicationRecord
  self.implicit_order_column = :name
end
