class Book < ApplicationRecord
  belongs_to :author
  has_many :editions, dependent: :destroy

  def self.fix_title
    Thread.start do
      Book.where(title: 'Pragmatic Programer').update(title: 'Pragmatic Programmer')
    end.join
  end
end
