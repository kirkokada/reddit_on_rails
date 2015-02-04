require 'test_helper'

class CommentingTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:michael)
  	@link = links(:google)
 		sign_in @user
  end

  test 'should create links the standard way' do
  	get link_path(@link)
  	content = "this link is pretty good"
  	assert_difference '@link.comments.count' do
  		post comments_path comment: { user_id: @user.id, 
  			                            link_id: @link.id,
  			                            content: content }
  	end
  	assert_redirected_to @link
  	follow_redirect!
  	assert_match content, response.body
  end

  test 'should create links via AJAX' do
  	get link_path(@link)
  	content = "this link is pretty good!"
  	assert_difference '@link.comments.count' do
  		xhr :post, comments_path, comment: { user_id: @user.id, 
  			                            	     link_id: @link.id,
  			                                   content: content }
  	end
  	assert_match content, response.body
  end

  test 'should delete links the normal way' do
  	comment = comments(:hello)
  	get link_path(@link)
  	assert_select "#comment-#{comment.id}"
  	assert_difference '@link.comments.count', -1 do
	  	delete comment_path(comment)
	  end
  	assert_redirected_to link_path(@link)
  	follow_redirect!
  	assert_select "#comment-#{comment.id}", count: 0
  end

  test 'should delete links with ajax' do
  	comment = comments(:hello)
  	get link_path(@link)
  	assert_select "#comment-#{comment.id}", count: 1
  	assert_difference '@link.comments.count', -1 do
	  	xhr :delete, comment_path(comment)
	  end
  	assert_select "#comment-#{comment.id}", count: 0
  end
end
