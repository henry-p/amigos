class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :content
      t.integer :creator_id
      t.integer :group_id

      t.timestamps
    end

    add_index :snippets, :creator_id
    add_index :snippets, :group_id
  end
end
