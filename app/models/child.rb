class Child < ApplicationRecord
  enum generation: { '' => 0, toddler: 1, preschool: 2, gradeschool: 3, teen: 4, young_adult: 5 }
end
