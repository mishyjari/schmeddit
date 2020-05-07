class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :categories, through: :comments
  has_many :user_favorite_posts
  has_many :user_favorite_categories
  has_many :user_post_votes
  has_many :user_comment_posts

  has_secure_password

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def user_voted?(post)
    self.user_post_votes.find_by(posr_id: post.id)
  end

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

  def user_favorites(n)
    self.user_favorite_posts.map do |fave|
      fave.post
    end.slice(0,n)
  end

  def sorted_posts
    self.posts.sort_by { |post| post.score * -1 }
  end

  def user_recent_posts(n)
    self.posts.most_recent_posts(n)
  end

end
