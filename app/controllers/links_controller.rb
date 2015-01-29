class LinksController < ApplicationController
	before_action :authenticate_user!

	def new
		@link = current_user.links.build
	end

  def create
  	@link = current_user.links.build(link_params)
  	if @link.save
  		flash[:success] = "Link submitted!"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def destroy
  end

  private
  def link_params
  	params.require(:link).permit(:title, :url)
  end
end
