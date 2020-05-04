class UserCommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user, uniqueness: { scope: :comment }
end
