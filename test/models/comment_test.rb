require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@comment = Comment.new(user_id: 1, link_id: 1, content: "test")
	end

	test 'should be valid' do
		assert @comment.valid?
	end

	test 'user_id should be present' do
		@comment.user_id = nil
		assert_not @comment.valid?
	end

	test 'link_id should be present' do
		@comment.link_id = nil
		assert_not @comment.valid?
	end
end
