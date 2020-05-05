class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :categories, through: :comments
  has_many :user_favorite_posts
  has_many :user_favorite_categories
  has_many :user_post_votes
  has_many :user_comment_posts

  def sorted_posts
    self.posts.sort_by { |post| post.score * -1 }
  end
end
