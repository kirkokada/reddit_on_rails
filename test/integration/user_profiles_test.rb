require 'test_helper'

class UserProfilesTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "profile page should show user's submitted links with delete links" do
		sign_in @user
		get user_path(@user)
		@user.links.paginate(page: 1).each do |link|
			assert_match link.title, response.body
			assert_match CGI.escapeHTML(link.url), response.body
			assert_select 'a[href=?]', link_path(link), text: 'delete'
		end
		sign_out
		get user_path(@user)
		@user.links.paginate(page: 1).each do |link|
			assert_select 'a[href=?]', link_path(link), text: 'delete', count: 0
		end
	end

	test 'should show user comments' do
		get user_comments_path(@user)
		@user.comments.paginate(page: 1).each do |comment|
			assert_select "#comment-#{comment.id}"
		end
	end

	test 'should show user links' do
		get user_links_path(@user)
		@user.links.paginate(page: 1).each do |link|
			assert_select "#link-#{link.id}"
		end
	end
end
