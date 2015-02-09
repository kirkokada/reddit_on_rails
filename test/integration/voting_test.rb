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
		assert_difference 'Link.find(@link.id).votes.count', 1 do
			post votes_path, link_id: @link.id, direction: 'up'
			post votes_path, link_id: @link.id, direction: 'down'
		end
		vote = Vote.find_by(user: @user, link: @link)
		assert_equal vote.value, -1
	end

	test 'should create a vote on a link with ajax' do
		assert_difference 'Link.find(@link.id).votes.count', 1 do
			xhr :post, votes_path, link_id: @link.id, direction: 'up'
			xhr :post, votes_path, link_id: @link.id, direction: 'down'
		end
		vote = Vote.find_by(user: @user, link: @link)
		assert_equal vote.value, -1
	end

	test 'should change a vote on a link the standard way' do
		patch vote_path(@vote), direction: 'neutral'
		assert_equal @vote.reload.value, 0
	end

	test 'should change a vote on a link with ajax' do
		xhr :patch, vote_path(@vote), direction: 'neutral'
		assert_equal @vote.reload.value, 0
	end

	test 'creating and updating votes should update link score' do
		link = links(:tbd)
		assert_equal 0, link.votes.count
		assert_difference 'Link.find(link.id).score', 1 do
			post votes_path, link_id: link.id, direction: 'up'
		end
		vote = link.votes.first
		assert_difference 'Link.find(link.id).score', -1 do
			patch vote_path(vote), direction: 'neutral'
		end
	end
end
