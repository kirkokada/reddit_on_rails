class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@user = User.find(params[:user_id])
		@comments = @user.comments.paginate(page: params[:page])
		respond_to do |format|
			format.html do
				@content = 'users/comments'
				render 'users/show'
			end
			format.js
		end
	end

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			respond_to do |format|
				format.html { redirect_to @comment.link }
				format.js 
			end
		else
			redirect_to root_url, flash[:danger] = "Something went wrong!"
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
		@comment = current_user.comments.build(parent_id: @parent.id, link_id: link.id)
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
