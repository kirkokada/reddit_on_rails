class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@links = @user.links.paginate(page: params[:page])
  end
end
