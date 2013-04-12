class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :init_layout

  def init_layout
    @galleries_for_layout = Gallery.last(6)
    @static_pages_for_layou = StaticPage.all
    @setting = Setting.first
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.role && current_user.role.title == 'admin'
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end
end
