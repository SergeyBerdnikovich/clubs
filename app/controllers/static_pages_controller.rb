class StaticPagesController < ApplicationController
  def index
    @static_pages = StaticPage.all
  end

  def show
    @static_page = StaticPage.find(params[:id])
  end
end
