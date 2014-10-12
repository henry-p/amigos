class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :member_id
      t.integer :group_id

      t.timestamps

    end
    add_index :memberships, :member_id
    add_index :memberships, :group_id
  end
end
