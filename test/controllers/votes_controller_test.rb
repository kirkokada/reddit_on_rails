require 'test_helper'

class VotesControllerTest < ActionController::TestCase
	include Devise::TestHelpers

	def setup
		@user = users(:michael)
		@link = links(:google)
	end

	test 'create should redirect non-signed in user' do
		assert_no_difference 'Vote.count' do
			post :create, link_id: @link.id, value: 1
		end
		assert_redirected_to new_user_session_url
	end

	test 'update should redirect non-signed in user' do
		patch :update, id: votes(:one).id, value: 0
		assert_redirected_to new_user_session_url
	end
end
