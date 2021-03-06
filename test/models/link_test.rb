require 'test_helper'

class LinkTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
    @subreddit = subreddits(:stuff)
		@link = @user.links.build(title:"TBA", url:"http://url.com", subreddit: @subreddit)
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

  test 'subreddit_id should be present' do
    @link.subreddit_id = nil
    assert_no_difference 'Link.count' do
      @link.save
    end
  end

  test 'update_score should update score' do
    link = links(:tbd)
    link.update_attribute(:score, 1)
    assert_equal 1, link.score
    assert_equal 0, link.votes.size
    link.update_score
    assert_equal 0, link.score
  end
end
