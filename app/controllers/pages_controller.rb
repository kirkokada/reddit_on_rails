class PagesController < ApplicationController
  def index
  	if current_user
	  	@links = current_user.front_page_links.paginate(page: params[:page])
	  else
	  	@links = Link.all.paginate(page: params[:page])
	  end
  end
end
