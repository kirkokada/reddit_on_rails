require 'test_helper'

class FrontPageTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "links for signed and non-signed in users" do
		get root_path
		assert_select "a[href=?]", new_user_registration_path
		assert_select "a[href=?]", new_user_session_path
		assert_select "a[href=?]", edit_user_registration_path, count: 0
		assert_select "a[href=?]", destroy_user_session_path,   count: 0
		sign_in @user
		get root_path
		assert_select "a[href=?]", new_user_registration_path, count: 0
		assert_select "a[href=?]", new_user_session_path,      count: 0
		assert_select "a[href=?]", edit_user_registration_path
		assert_select "a[href=?]", destroy_user_session_path
		@user.front_page_links.paginate(page: 1).each do |link|
			assert_select "a[href=?]", link.url, text: link.title
		end
	end
end
