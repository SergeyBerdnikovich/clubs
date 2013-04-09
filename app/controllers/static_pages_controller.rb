class StaticPagesController < ApplicationController
  def show
    @static_page = StaticPage.find(params[:id])
  end

  def welcome
    @static_page = StaticPage.first
  end
end
