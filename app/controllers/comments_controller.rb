class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@comment = Comment.new(comment_params)
		@comment.save
		respond_to do |format|
			format.html { redirect_to @comment.link }
			format.js 
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@link = @comment.link
		redirect_to root_url unless @comment.user == current_user
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @link }
			format.js
		end
	end

	def edit
		@comment = Comment.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			respond_to do |format|
				format.html { redirect_to @comment.link }
				format.js
			end
		else
			render 'edit'
		end
	end

	def reply
		@parent = Comment.find(params[:id])
		link = @parent.link
		@comment = Comment.new(user: current_user, parent: @parent, link: link)
		respond_to do |format|
			format.html
			format.js
		end
	end

	private

	 def comment_params
	 	params.require(:comment).permit(:content, :user_id, :link_id, :parent_id)
	 end
end
