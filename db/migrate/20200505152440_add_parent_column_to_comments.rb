class AddParentColumnToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :post_id
    add_column :comments, :parent_id, :integer
    add_column :comments, :parent_type, :string

    add_index :comments, [:parent_type, :parent_id]
  end
end
