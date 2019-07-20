class User < ApplicationRecord
  has_many :languages, as: :developer, dependent: :nullify
end
