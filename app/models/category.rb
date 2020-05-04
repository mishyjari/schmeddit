class Category < ApplicationRecord
  has_many :posts
  has_many :user_favorite_categories
end
