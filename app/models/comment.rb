class Comment < ApplicationRecord
  has_many :user_comment_votes
  has_many :replies, class_name: "Comment", as: :parent
  belongs_to :parent, polymorphic: true
  belongs_to :user
end
