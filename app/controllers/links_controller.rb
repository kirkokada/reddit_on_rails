class LinksController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :destroy]

	def new
		@link = current_user.links.build
	end

  def create
  	@link = current_user.links.build(link_params)
  	if @link.save
  		flash[:success] = "Link submitted!"
  		redirect_to @link
  	else
  		render 'new'
  	end
  end

  def show
    @link = Link.find(params[:id])
    @comments = @link.comments
    if current_user.present?
      @comment = Comment.new(link_id: @link.id, user_id: current_user.id)
    end
  end

  def destroy
    @link = Link.find(params[:id])
    if current_user == @link.user
      @link.destroy
      respond_to do |format|
        format.html do 
          flash.now[:success] = "Link deleted."
          redirect_to root_url
        end
        format.js
      end
    else
      redirect_to root_url
    end
  end

  private
  def link_params
  	params.require(:link).permit(:title, :url, :description)
  end
end
