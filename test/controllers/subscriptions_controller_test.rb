require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
	include Devise::TestHelpers

  test "create should redirect un-signed in user" do
  	assert_no_difference 'Subscription.count' do
  		post :create, subscription: { user_id: 1,
  		                              subreddit_id: 1 }
  	end	
  	assert_redirected_to new_user_session_path
  end

end
