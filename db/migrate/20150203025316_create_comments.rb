class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :link_id
      t.text :content
      t.integer :parent_id

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :link_id
  end
end
