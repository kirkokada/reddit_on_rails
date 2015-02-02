require 'test_helper'

class VotingTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@link = links(:tbd)
		@vote = votes(:one)
		sign_in @user
	end

	test 'should create a vote on a link the standard way' do
		# Test that multiple voting on the same link does not create two votes
		assert_difference '@link.votes.count', 1 do
			post votes_path, link_id: @link.id, value: 1
			post votes_path, link_id: @link.id, value: -1
		end
		vote = Vote.find_by(user: @user, link: @link)
		assert_equal vote.value, -1
	end

	test 'should create a vote on a link with ajax' do
		assert_difference '@link.votes.count', 1 do
			xhr :post, votes_path, link_id: @link.id, value: 1
			xhr :post, votes_path, link_id: @link.id, value: -1
		end
		vote = Vote.find_by(user: @user, link: @link)
		assert_equal vote.value, -1
	end

	test 'should change a vote on a link the standard way' do
		patch vote_path(@vote), value: 0
		assert_equal @vote.reload.value, 0
	end

	test 'should change a vote on a link with ajax' do
		xhr :patch, vote_path(@vote), value: 0
		assert_equal @vote.reload.value, 0
	end
end
