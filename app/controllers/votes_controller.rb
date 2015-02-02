class VotesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy]
	
	def create
		@link = Link.find(params[:link_id])
		value = params[:value]
		current_user.vote(@link, value)
		respond_to do |format|
			format.html { redirect_to @link }
			format.js
		end 
	end

	def update
		@link = Vote.find(params[:id]).link
		value = params[:value]
		current_user.vote(@link, value)
		respond_to do |format|
			format.html { redirect_to @link }
			format.js   { render 'create' }
		end
	end
end
