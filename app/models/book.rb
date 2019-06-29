class Book < ApplicationRecord
  connects_to database: { writing: :library, reading: :library }
end
