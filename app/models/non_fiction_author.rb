class NonFictionAuthor < Author
  has_many :books, foreign_key: :author_id
  accepts_nested_attributes_for :books
end
