class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :categories, through: :comments
  has_many :user_favorite_posts
  has_many :user_favorite_categories
  has_many :user_post_votes
  has_many :user_comment_posts

  has_secure_password

  def user_up_vote?(post)
    vote = self.user_post_votes.find_by(post_id: post.id)
    vote && vote.up_vote?
  end

  def user_down_vote?(post)
    vote = self.user_post_votes.find_by(post_id: post.id)
    vote && !vote.up_vote?
  end

  def user_favorited?(post)
    fave = self.user_favorite_posts.find_by(post_id: post.id)
    fave 
  end

  def sorted_posts
    self.posts.sort_by { |post| post.score * -1 }
  end
end
