class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :group_id
      t.integer :creator_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
