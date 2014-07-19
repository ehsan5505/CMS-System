class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_login
    unless (session[:user_id]) && (session[:admin_type]=="admin")
      flash[:notice] = "Kindly Sign In"
      redirect_to :controller=>"access",:action=>"login"
      return false
    else
      return true
    end
  end
  
end
