class Category < ApplicationRecord
  has_many :posts
  has_many :user_favorite_categories

  def top_three_posts
    self.posts.sort_posts_by_most_liked.slice(0,3)
  end

  def most_favorited_post_in_category
    self.posts.sort_posts_by_most_favorites.first
  end
end
