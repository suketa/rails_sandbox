class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :called_from, ->(from) { annotate("called from #{from}") }
end
