class RemoveRepliesTable < ActiveRecord::Migration[6.0]
    def change 
      drop_table :replies do |t|
        t.integer :parent_id, null: false
        t.integer :child_id, null: false
        t.timestamps null: false
      end
    end
end
