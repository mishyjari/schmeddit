class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, foreign_key: 'parent_id'
  has_many :user_comment_votes
end
