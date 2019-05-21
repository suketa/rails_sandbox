class User < ApplicationRecord
  self.filter_attributes += [:sensitive]
end
