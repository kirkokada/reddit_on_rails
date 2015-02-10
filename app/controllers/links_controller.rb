class LinksController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @content = @user.links.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])
    respond_to do |format|
      format.html do
        render 'users/show'
      end
      format.js
    end
  end

	def new
		@link = current_user.links.build()
	end

  def create
  	@link = current_user.links.build(link_params)
    @link.subreddit = Subreddit.find_by(name: params[:subreddit])
  	if @link.save
  		flash[:success] = "Link submitted!"
  		redirect_to @link
  	else
  		render 'new'
  	end
  end

  def show
    @link = Link.find(params[:id])
    @comments = @link.top_level_comments
    if current_user.present?
      @comment = Comment.new(link: @link, user: current_user)
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

  def sort_column
    Link.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
