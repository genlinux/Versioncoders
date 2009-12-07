class BlogsController < ApplicationController
  layout 'pages'
  def index
      @entries=Entry.order.include_user.paginate(:page =>params[:page], :per_page =>10)
  end
end
