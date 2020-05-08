class Category < ApplicationRecord
  has_many :posts
  has_many :user_favorite_categories

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 60 }

  def top_three_posts
    self.posts.sort_by{|post| -post.score }.slice(0,3)
  end
end
