class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # --- Will be added by 'devise' gem
      # t.string :email
      # ---
      # 
      # --- Will not be needed, because of 'devise' gem
      # t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :current_location

      t.timestamps
    end
  end
end
