class AdminController < ApplicationController
  
	layout "admin"

	before_action :confirm_login

  def index
  	@admins = AdminUser.sorted
  end

  def new
  	@admin = AdminUser.new
  end

  def create
  	@admin = AdminUser.new(post_param)
  	if @admin.save
  		flash[:notice] = "#{@admin.name} is created Successfully"
  		redirect_to :action=>"index"
  	else
  		flash[:notice] = "Error in Admin User, failed to create it"
  		render :action=>"new"
  	end
  end

  def edit
  	@admin = AdminUser.find(params[:id])
  end

  def update
  	@admin = AdminUser.find(params[:id])
  	if @admin.update_attributes(post_param)
  		flash[:notice] = "Update #{@admin.name} is Successful"
  		redirect_to :action=>"index"
  	else
  		flash[:notice] = "Fail to update #{@admin.name}"
  		render :action=>"edit",:id=>@admin.id
  	end
  end

  def delete
  	@admin = AdminUser.find(params[:id])
  end
  
  def destroy
  	@admin = AdminUser.find(params[:id])
  	if @admin.destroy
  		flash[:notice] = "#{@admin.name} is Deleted Successfully"
  		redirect_to :action=>"index"
  	end
  end
  	
  private

  def post_param
  	params.require(:admin).permit(:first_name,:last_name,
  		:email,:username,:password,:password_confirmation)
  end

end
