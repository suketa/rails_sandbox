class Bug < ApplicationRecord
  # has_many :bug_children, foreign_key: :other_id, dependent: :destroy, inverse_of: :bug
  has_many :bug_children, foreign_key: :other_id, dependent: :destroy

  after_update_commit do
    puts 'after_update_commit'
  end

  after_destroy_commit do
    puts 'after_destroy_commit'
  end

  def self.bbb
    # bug = Bug.create!
    bug = Bug.create!(name: "#{self}##{__method__}")
    bug.bug_children.create!
    bug.bug_children.create!
    # BugChild.create!(bug: bug)
    # BugChild.create!(bug: bug)
    bug.destroy!
  end
end
