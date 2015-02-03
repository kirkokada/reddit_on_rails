require 'test_helper'

class DeletingLinksTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@link = links(:google)
		sign_in @user
	end

	test 'deleting a link the standard way' do
		get link_path(@link)
		assert_difference 'Link.count', -1 do
			delete link_path(@link)
		end
		assert_redirected_to root_url
	end

	test 'deleting a link with ajax' do
		get link_path(@link)
		assert_difference 'Link.count', -1 do
			xhr :delete, link_path(@link)
		end
		assert_select "#link_form-#{@link.id}", count: 0
	end
end
