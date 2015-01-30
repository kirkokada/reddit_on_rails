require 'test_helper'

class CreatingLinksTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:michael)
  end

  test "creating and showing a link" do
  	sign_in @user
  	get new_link_path
  	post links_path, link: { title: "title", url: "stuff.com", user_id: @user.id }
  	@link = assigns(:link)
    assert_redirected_to @link
    follow_redirect!
    assert_match CGI.escapeHTML(@link.url), response.body
    assert_match @link.title, response.body
    assert_match @user.name, response.body
    sign_out
    assert_redirected_to root_url
  end

  test "invalid link information" do
  	sign_in @user
  	get new_link_path
  	assert_no_difference 'Link.count' do
  		post links_path, link: { title: "",
  		                         url:   "(^_^ )",
  		                         user_id: nil}
  	end
  	assert_template 'links/new'
  end
end
