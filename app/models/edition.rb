class Edition < ApplicationRecord
  belongs_to :book

  def self.fix_name
    Thread.start do
      Edition.where(name: '2nd').update(name: '20th Anniversary Edition')
    end.join
  end
end
