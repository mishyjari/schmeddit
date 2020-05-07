class AddNumFavoritesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :num_favorites, :integer
  end
end
