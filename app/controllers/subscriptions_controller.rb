class SubscriptionsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @subreddit = Subreddit.find(params[:subreddit_id])
  	if @subscription = current_user.subscribe(@subreddit)
    	respond_to do |format|
    		format.html { redirect_to @subreddit }
    		format.js
    	end
    else
    	redirect_to root_url, flash[:danger] = "Something went wrong."
    end
  end

  def destroy
    @subreddit = Subscription.find(params[:id]).subreddit
    current_user.unsubscribe(@subreddit)
    respond_to do |format|
      format.html { redirect_to @subreddit }
      format.js 
    end
  end
end
