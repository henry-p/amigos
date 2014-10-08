class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :content
      t.integer :creator_id
      t.integer :group_id

      t.timestamps
    end
  end
end
