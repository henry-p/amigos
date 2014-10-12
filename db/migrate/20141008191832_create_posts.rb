class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :group_id
      t.integer :creator_id
      t.string :title
      t.text :content

      t.timestamps
    end

    add_index :posts, :group_id
    add_index :posts, :creator_id
  end
end
