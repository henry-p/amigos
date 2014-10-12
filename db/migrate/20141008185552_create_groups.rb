class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :jefe_id

      t.timestamps
    end

    add_index :groups, :jefe_id
  end
end
