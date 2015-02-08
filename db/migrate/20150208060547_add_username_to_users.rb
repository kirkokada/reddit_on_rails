class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index  :users, :username, unique: true
    remove_column :users, :name
  end
end
