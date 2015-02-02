class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :value, default: 0

      t.timestamps null: false
    end
    add_index :votes, :user_id
    add_index :votes, :link_id
    add_index :votes, [:user_id, :link_id], unique: true
  end
end
