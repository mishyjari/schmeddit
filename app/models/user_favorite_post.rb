class UserFavoritePost < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
