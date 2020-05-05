class Category < ApplicationRecord
  has_many :posts
  has_many :user_favorite_categories

  def most_liked_post_in_category
    self.posts.sort_posts_by_most_liked.first
  end

  def most_favorited_post_in_category
    self.posts.sort_posts_by_most_favorites.first
  end
end
