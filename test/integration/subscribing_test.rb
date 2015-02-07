require 'test_helper'

class SubscribingTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@subreddit = subreddits(:stuff)
		sign_in @user
  end

  test 'subscribing to a subreddit with ajax' do
		get subreddit_path(@subreddit)
		assert_select 'form#new_subscription' 
		assert_difference '@user.subscriptions.count', 1 do
			xhr :post, subscriptions_path, subreddit_id: @subreddit.id
		end
	end

  test 'unsubscribing from a subreddit with ajax' do
    @user.subscribe(@subreddit)
    get subreddit_path(@subreddit)
    assert_select 'form.edit_subscription'
    subscription = @user.subscriptions.find_by(subreddit_id: @subreddit.id)
    assert_difference '@user.subscriptions.count', -1 do
      xhr :delete, subscription_path(subscription)
    end
  end
end
