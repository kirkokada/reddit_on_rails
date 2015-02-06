class SubredditsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@subreddit = current_user.subreddits.build()
  end

  def create
  	@subreddit = Subreddit.new(new_subreddit_params)
  	if @subreddit.save
  		redirect_to @subreddit
  	else
  		render 'new'
  	end
  end

  def show
  	@subreddit = Subreddit.find_by(name: params[:id].downcase)
    if @subreddit
      @links = @subreddit.links.paginate(page: params[:page])
    else
      flash[:info] = "Subreddit not found (T_T )"
      redirect_to root_url
    end
  end

  def edit
  end

  def update
    @subreddit.update_attributes(edit_subreddit_params)
    flash[:success] = "Changes saved"
    redirect_to @subreddit
  end

  def destroy
    @subreddit.destroy
    flash[:success] = "Subreddit deleted."
    redirect_to root_url
  end

  private

  	def new_subreddit_params
  		params.require(:subreddit).permit(:user_id, :name, :description)
  	end

    def edit_subreddit_params
      params.require(:subreddit).permit(:description)
    end

    def correct_user
      @subreddit = Subreddit.find_by(name: params[:id].downcase)
      redirect_to root_url unless @subreddit && current_user == @subreddit.user
    end
end
