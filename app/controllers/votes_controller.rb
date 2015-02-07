class VotesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy]
	
	def create
		@link = Link.find(params[:link_id])
		direction = params[:direction]
		current_user.vote(@link, direction)
		respond_to do |format|
			format.html { redirect_to @link }
			format.js
		end 
	end

	def update
		@link = Vote.find(params[:id]).link
		direction = params[:direction]
		current_user.vote(@link, direction)
		respond_to do |format|
			format.html { redirect_to @link }
			format.js   { render 'create' }
		end
	end
end
