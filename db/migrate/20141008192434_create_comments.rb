class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :creator_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end

    add_index :comments, :creator_id
    add_index :comments, :commentable_id
  end
end
