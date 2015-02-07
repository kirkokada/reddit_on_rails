require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'shoud subscribe and unsubscribe to a subreddit' do
  	user = users(:michael)
  	subreddit = subreddits(:stuff)
  	assert_not user.subscribed?(subreddit)
  	user.subscribe(subreddit)
  	assert user.subscribed?(subreddit)
  	user.unsubscribe(subreddit)
  	assert_not user.subscribed?(subreddit)
  end

  test 'should vote on links' do
  	link = links(:google)
  	user = users(:michael)
  	user.vote(link, 'up')
  	vote = user.votes.find_by(link: link)
  	assert_equal vote.value, 1
  	user.vote(link, 'down')
  	assert_equal vote.reload.value, -1
  	user.vote(link, 'neutral')
  	assert_equal vote.reload.value, 0
  end
end
