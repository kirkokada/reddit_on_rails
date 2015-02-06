class AddSubredditIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :subreddit_id, :integer
  end
end
