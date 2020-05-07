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
    self.user_favorite_posts.count
  end

  def num_post_votes
    self.user_post_votes.count
  end

  def num_post_upvotes
    #self.user_post_votes.select{ |vote| vote.up_vote? }.count
    0
  end

  def num_post_downvotes
    #self.user_post_votes.select{ |vote| !vote.up_vote? }.count
    0
  end

  def score
    self.num_post_upvotes - self.num_post_downvotes
  end

  def self.top_scoring(n)
    Post.all.sort_posts_by_score.slice(0,n)
  end

  def self.sort_posts_by_score
    Post.all.sort_by{ |post| post.score * -1 }
  end

  def self.sort_posts_by_most_favorites
    Post.all.sort_by{ |post| post.num_post_faves * -1 }
  end

  def self.sort_posts_by_most_liked
    Post.all.sort_by{ |post| post.num_post_upvotes * -1 }
  end
  
  def self.most_recent_posts(n)
    Post.all.order({ created_at: :desc }).slice(0,n)
  end

  def up_vote_post(user)
    UserPostVote.create(post_id: self.id, user_id: user.id, up_vote?: true)
  end

  def down_vote_post(user)
    UserPostVote.create(post_id: self.id, user_id: user.id, up_vote?: false)
  end

  def favorite_post(user)
    UserFavoritePost.create(post_id: self.id, user_id: user.id)
  end

  def truncate_content(max_characters)
    if self.content.length > max_characters
      self.content.slice(0,max_characters) + '...'
    else
      self.content
    end
  end
end
