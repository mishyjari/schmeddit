class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, as: :parent
  has_many :user_post_votes
  has_many :user_favorite_posts

  def self.random_posts(n)
    posts = []
    n.times do 
      post = Post.all.sample
      while posts.include?(post)
        # Post has already been selected, try again
        post = Post.all.sample
      end
      posts << post
    end
    posts 
  end

  def num_post_faves
    self.num_favorites
  end

  def self.top_scoring(n)
    Post.all.sort_by{|p| p.score}.slice(0,n)
  end

  def self.most_recent_posts(n)
    Post.all.order({ created_at: :desc }).slice(0,n)
  end

  def truncate_content(max_characters)
    if self.content.length > max_characters
      self.content.slice(0,max_characters) + '...'
    else
      self.content
    end
  end
end
