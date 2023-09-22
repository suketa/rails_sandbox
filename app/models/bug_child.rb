class BugChild < ApplicationRecord
  belongs_to :bug, foreign_key: :other_id

  after_destroy do
    p bug.object_id #1回目と2回目で異なるid
    bug.update!(id: bug.id)
    bug.destroy! if bug.bug_children.empty?
  end
end
