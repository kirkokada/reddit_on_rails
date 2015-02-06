require 'test_helper'

class SubredditsTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test 'creating a subreddit with invalid information' do
		sign_in @user
		get new_subreddit_url
		assert_no_difference 'Subreddit.count' do
			post subreddits_path, subreddit: { name: '', 
													               user_id: @user.id, 
													               description: "good shit" }
		end
		assert_template 'subreddits/new'
	end

	test 'creating a subreddit with valid information' do
		sign_in @user
		get new_subreddit_url
		assert_difference 'Subreddit.count' do
			post subreddits_path, subreddit: { name: 'name', 
													               user_id: @user.id, 
													               description: "good shit" }
		end
		subreddit = assigns(:subreddit)
		assert_redirected_to subreddit
	end

	test 'subreddit show page' do
		subreddit = subreddits(:stuff)
		get subreddit_path(subreddit)
		assert_match subreddit.name, response.body
		assert_match subreddit.description, response.body
		assert_select 'a[href=?]', new_link_path(subreddit: subreddit.name)
		subreddit.links.paginate(page: 1).each do |link|
			assert_select "#link-#{link.id}"
		end
	end

	test 'edit subreddit page' do
		subreddit = subreddits(:stuff)
		sign_in @user
		get edit_subreddit_path(subreddit)
		assert_select 'form'
		assert_select 'a[href=?][data-method=?]', subreddit_path(subreddit), 'delete'
	end

	test 'updating a subreddit' do
		subreddit = subreddits(:stuff)
		sign_in @user
		patch subreddit_path(subreddit), subreddit: { description: 'new description' }
		assert_not_equal subreddit.description, subreddit.reload.description
	end

	test 'deleting a subreddit' do
		subreddit = subreddits(:stuff)
		sign_in @user
		assert_difference 'Subreddit.count', -1 do
			delete subreddit_path(subreddit)
		end
		assert_redirected_to root_url
	end
end
