class Language < ApplicationRecord
  belongs_to :developer, polymorphic: true, optional: true
end
