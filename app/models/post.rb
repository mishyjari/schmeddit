class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :user_post_votes
  has_many :user_post_favorites
end
