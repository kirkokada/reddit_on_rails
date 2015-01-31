require 'test_helper'

class UserProfilesTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "profile page should show user's submitted links" do
		get user_path(@user)
		@user.links.paginate(page: 1).each do |link|
			assert_match link.title, response.body
			assert_match CGI.escapeHTML(link.url), response.body
		end
	end
end
