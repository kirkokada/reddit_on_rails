require 'test_helper'

class SubredditsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	
  test "should redirect new when not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should redirect get edit when not signed in" do
  	get :edit, id: 1
    assert_redirected_to new_user_session_path
  end

  test "should redirect edit when not correct user" do
  	wrong_user = users(:gob)
  	subreddit = subreddits(:stuff)
  	sign_in wrong_user
  	get :edit, id: subreddit.id
  	assert_redirected_to root_url 
  end

  test "should redirect update when not signed in" do
  	patch :update, id: 1
  	assert_redirected_to new_user_session_path
  end

  test "should redirect update when not correct user" do
  	wrong_user = users(:gob)
  	subreddit = subreddits(:stuff)
  	sign_in wrong_user
  	patch :update, id: subreddit.id
  	assert_redirected_to root_url
  end
end
