require 'test_helper'

class VoteTest < ActiveSupport::TestCase
	def setup
	 	@vote = Vote.new(link_id: 1, user_id: 1, value: 0)
	end 

	test 'should be valid' do
		assert @vote.valid?
	end

	test 'should require link_id' do
		@vote.link_id = nil
		assert_not @vote.valid?
	end

	test 'should require user_id' do
		@vote.user_id = nil
		assert_not @vote.valid?
	end

	test 'should require value' do
		@vote.value = nil
		assert_not @vote.valid?
	end

	test 'value should be between -1 and 1' do
		@vote.value = -2
		assert_not @vote.valid?
		@vote.value = 2
		assert_not @vote.valid?
	end
end
