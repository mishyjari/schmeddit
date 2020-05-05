class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments
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
    self.user_favorite_posts.count
  end

  def num_post_votes
    self.user_post_votes.count
  end

  def num_post_upvotes
    self.user_post_votes.select{ |vote| vote.up_vote? }.count
  end

  def num_post_downvotes
    self.user_post_votes.select{ |vote| !vote.up_vote? }.count
  end

  def self.sort_posts_by_most_favorites
    Post.all.sort_by{ |post| post.num_post_faves * -1 }
  end

  def self.sort_posts_by_most_liked
    Post.all.sort_by{ |post| post.num_post_upvotes * -1 }
  end
end
