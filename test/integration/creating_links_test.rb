require 'test_helper'

class CreatingLinksTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:michael)
    @subreddit = subreddits(:stuff)
  end

  test "creating and showing a link" do
  	sign_in @user
  	get new_link_path
    assert_difference 'Link.count' do
    	post links_path, link: { title: "title", 
                               url: "stuff.com", 
                               user_id: @user },
                       subreddit: @subreddit.name 
    end
  	@link = assigns(:link)
    assert_redirected_to @link
    follow_redirect!
    assert_match CGI.escapeHTML(@link.url), response.body
    assert_match @link.title, response.body
    assert_match @user.name, response.body
    assert_select 'a[href=?]', subreddit_path(@subreddit)
    get subreddit_path(@subreddit)
    assert_select 'a[href=?]', @link.url, text: @link.title
  end

  test "invalid link information" do
  	sign_in @user
  	get new_link_path
  	assert_no_difference 'Link.count' do
  		post links_path, link: { title: "",
  		                         url:   "(^_^ )",
  		                         user_id: nil,
                               subreddit: nil }
  	end
  	assert_template 'links/new'
  end
end
