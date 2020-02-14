class Child < ApplicationRecord
  enum generation: %i[baby not_baby]
end
