class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
