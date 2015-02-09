require 'test_helper'

class VoteTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
		@link = links(:tbd)
	 	@vote = Vote.new(link_id: @link.id, user_id: @user.id, value: 0)
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

	test 'up should set value to 1' do
		assert_difference '@vote.value', 1 do
			@vote.up
		end
	end

	test 'down should set value to -1' do
		assert_difference '@vote.value', -1 do
			@vote.down
		end
	end

	test 'neutral should set value to 0' do
		@vote.value = 1
		@vote.save
		@vote.neutral
		assert_equal 0, @vote.reload.value
	end
end
