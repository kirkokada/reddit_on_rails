require 'test_helper'

class SubredditTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
	end

  test 'name uniqueness should be case insensitive' do
  	subreddit = Subreddit.create(name: 'name', user: @user)
  	dup_sub = subreddit.dup
  	dup_sub.name.upcase!
  	assert_no_difference 'Subreddit.count' do
  		dup_sub.save
  	end
  end

  test 'name should contain only letters, numbers, and underscores' do
  	subreddit = Subreddit.new(user: @user, 
  		                        name: '!$_** 0',
  		                        description: "not a valid name")
  	assert_no_difference 'Subreddit.count' do
  		subreddit.save
  	end
  end

  test 'name should be downcased before saving' do
  	name = 'NAME'
  	subreddit = Subreddit.new(name: name, user_id: @user.id)
  	assert_difference 'Subreddit.count' do
  		subreddit.save
  	end
  	assert_equal subreddit.reload.name, name.downcase 
  end
end
