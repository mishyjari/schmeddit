class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies
  has_many :comments, through: :replies
  has_many :user_comment_votes
end
