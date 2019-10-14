class Author < ApplicationRecord
  has_many :books
  has_many :publishers, -> { distinct }, through: :books

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
