require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'create should redirect non-signed in user' do
  	assert_no_difference 'Comment.count' do
  		post :create, comment: { user_id: 1 }
  	end
  	assert_redirected_to new_user_session_path
  end

  test 'destroy should redirect non-signed in user' do
  	assert_no_difference 'Comment.count' do
  		delete :destroy, id: 1
  	end
  	assert_redirected_to new_user_session_path
  end

  test 'edit should redirect non-signed in user' do
    comment = comments(:hello)
    get :edit, id: comment.id
    assert_redirected_to new_user_session_path
  end

  test 'update should redirect non-signed in user' do
    comment = comments(:hello)
    patch :update, id: comment.id, comment: { content: "rawr" }
    assert_redirected_to new_user_session_path
    assert_equal comment.content, comment.reload.content
  end
end
