class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, as: :parent
  has_many :user_post_votes
  has_many :user_favorite_posts

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { maximum: 60 }

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

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
    where("content LIKE ?", "%#{search}%")
  end

  def num_post_faves
    self.num_favorites
  end

  def self.top_scoring(n)
    Post.all.sort_by{|p| -p.score}.slice(0,n)
  end

  def date_favorited(user)
    self.user_favorite_posts.find_by(user_id: user.id)
  end

  def self.most_recent_posts(n)
    self.order({ created_at: :desc }).slice(0,n)
  end

  def truncate_content(max_characters)
    if self.content.length > max_characters
      self.content.slice(0,max_characters) + '...'
    else
      self.content
    end
  end
end
