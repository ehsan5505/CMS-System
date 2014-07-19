class AccountController < ApplicationController

	layout "admin"

  def login
  end

  def account
  	@admin = AdminUser.new
  end

  def create
  	@user = AdminUser.new post_params
  	if @user.save
  		session[:user_id] = @user.id
  		session[:username] = @user.username
  		session[:admin_type] = @user.admin_type
  		redirect_to :controller => "public"
  	else
  		flash[:notice] = "There are some errors"
  		render :action => "account"
  	end
  end

  def login_attempt
  	if params[:username].present? && params[:password].present?
  		@user = AdminUser.where(:username=>params[:username]).first
  		if @user
  			@found = @user.authenticate(params[:password])
  		end
  		if @found
  			session[:user_id] = @found.id
  			session[:username] = @found.username
  			session[:admin] = @found.admin_type
  				
  			if @found.admin_type == "admin"
  				redirect_to :controller=>"access",:action=>"index"
  			else
  				redirect_to :controller=>"public",:action=>"index",:jkMxnas=>:true
  			end
  		else
  			flash[:notice] = "Username and Password are invalid. Check Caps-Lock to be Off"
  			render :action=>"login"
  		end
  	end
  end

  def post_params
  	params.require(:admin).permit(:first_name,:last_name,
  		:email,:username,:password,:password_confirmation )
  end


end
