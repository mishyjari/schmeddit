class CreateUserCommentVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_comment_votes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :comment, null: false, foreign_key: true
      t.boolean :up_vote?

      t.timestamps
    end
  end
end
