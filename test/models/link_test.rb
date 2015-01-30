require 'test_helper'

class LinkTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
		@link = @user.links.build(title:"TBA", url:"http://url.com")
	end

  test "link url should be formatted properly" do
  	url = "shemale.com"
  	@link.url = url
  	assert_difference 'Link.count', 1 do
  		@link.save
  	end
  	assert_equal @link.reload.url, "http://#{url}" 
  end

  test "https url should not be altered" do
  	url = "https://bleuth.com"
  	@link.url = url
  	assert_difference 'Link.count', 1 do
  		@link.save
  	end
  	assert_not_equal @link.reload.url, "http://bleuth.com"
  end

  test "user id should be present" do
  	@link.user_id = nil
  	assert_no_difference 'Link.count' do
  		@link.save	
  	end
  end
end
