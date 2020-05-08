class Comment < ApplicationRecord
  has_many :user_comment_votes
  has_many :replies, class_name: "Comment", as: :parent
  belongs_to :parent, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :content, length: { maximum: 500 }

  def find_parent_post
    parent = self.parent
    while parent.class != Post
      parent = parent.parent 
    end
    parent
  end 
end
