class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :subreddits, :name, unique: true
  end
end
