class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :categories, through: :comments
  has_many :user_favorite_posts
  has_many :user_favorite_categories
  has_many :user_post_votes
  has_many :user_comment_posts
  has_many :replies
  has_many :parents, through: :replies
  has_many :children, through: :replies 
end
