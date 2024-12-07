class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :google_id, null: false 
      t.string :name, null: false 
      t.string :email, null: false 

      t.timestamps
    end
    # Add uniqueness constraints
    add_index :users, :google_id, unique: true  # Ensure google_id is unique
    add_index :users, :email, unique: true      # Ensure email is unique

  end
end
