class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@activity = @user.activity.paginate(page: params[:page], per_page: 10)
  	respond_to do |format|
  		format.html { @content = 'overview' }
  		format.js
  	end
  end
end
