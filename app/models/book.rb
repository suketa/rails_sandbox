class Book < ApplicationRecord
  belongs_to :author

  scope :with_title, ->(title) { where('title like ?', "%#{title}%") }
  scope :ruby, -> { with_title('Ruby') }
  scope :rails, -> { with_title('Rails') }
end
