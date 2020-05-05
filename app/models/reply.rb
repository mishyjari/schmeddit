class Reply < ApplicationRecord
  belongs_to :parent, :class_name => 'Comment'
  belongs_to :child, :class_name => 'Comment'

  def reply_comment
    Comment.find(self.child)
  end
end
