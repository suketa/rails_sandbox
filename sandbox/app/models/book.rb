class Book < ApplicationRecord
  attribute :genre, :integer, default: 0
  enum genre: { fiction: 0, non_fiction: 1 }, _prefix: true
end
