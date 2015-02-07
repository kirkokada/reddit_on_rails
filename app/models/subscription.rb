class Subscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :subreddit

	validates_presence_of :user_id
	validates_presence_of :subreddit_id
end
