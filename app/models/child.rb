class Child < ApplicationRecord
  enum generation: %i[baby toddler preschool gradeschool teen young_adult] 
end
