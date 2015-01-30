require 'test_helper'

class LinksControllerTest < ActionController::TestCase
	include Devise::TestHelpers

	test 'new should redirect non-logged-in user' do
		get :new
		assert_redirected_to new_user_session_path
	end

	test 'create should redirect non-logged in user' do
		assert_no_difference 'Link.count' do
			post :create, link: { url: "", title: "", user_id: ""}
		end
		assert_redirected_to new_user_session_path
	end

	test 'destroy should redirect non-logged in user' do
		assert_no_difference 'Link.count' do
			delete :destroy, id: 1
		end
		assert_redirected_to new_user_session_path
	end
end
