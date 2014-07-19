class AccessController < ApplicationController

	layout "admin"

  before_action   :confirm_login, :except=>[:login,:logout,:login_attempt]

  def index
  	@subjects= Subject.sorted
  	@pages	=	Page.sorted
  	@sections =	Section.sorted
    @admins = AdminUser.sorted
  end

  def login
  end

  def login_attempt
  	if params[:username].present? && params[:password].present?
  	  	found_user = AdminUser.where( :username => params[:username] ).first
  		  if found_user
  			  user = found_user.authenticate(params[:password])
  		  end
  	end
  	if user
      session[:user_id] = user.id
      session[:username] = user.username
      session[:admin_type] = user.admin_type
  		flash[:notice] = "Welcome to the Admin Mr #{user.first_name} #{user.last_name}"
  		redirect_to :action=>"index"
  	else
  		flash[:notice] = "Invalid Username and Password #{@step} #{@value}"
  		redirect_to :action=>"login"
  	end
  end

  def logout
    session[:user_id]  = nil
    session[:username] = nil
    session[:admin_type] = nil
    flash[:notice] = "Logout Successful"
    redirect_to :action=>"login"
  end


end
