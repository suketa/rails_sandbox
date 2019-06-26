class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.fix_name
    Thread.start do
      Author.where(name: 'Dave Tomas').update(name: 'Dave Thomas')
    end.join
  end
end
