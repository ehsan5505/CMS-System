class PublicController < ApplicationController
  
 	before_action	:get_navigation

  def index
  end

  def show
  		@article = Section.where(:permalink=>params[:permalink]).first
  	if @article.nil?
  		redirect_to :action=>index
  	end

  end

  def login
    redirect_to :action=>"login",:controller=>"account"
  end

  def logout
    if session
      session[:user_id] = nil
      session[:username] = nil
      session[:admin_type] = nil
      redirect_to :action=>"index"
    end
  end


  def search
    if params[:search].present?
      #@result = Section.search(params[:search]).sorted.visible
      #@subject = Subject.where(:name=>"Content").first
      #@pages = Page.where(:subject_id=>@subject.id).visible
      #@result = @pages.sections
      @result = Section.where(["name LIKE ?","%#{params[:search]}%"]).visible
      @status = "#{@result.count} article are founded for #{params[:search]}"
      render :action=>"search"
    else
      @status = "Kuch nae mila"
      redirect_to :action=>"index"
    end
  end

  def get_navigation
  		#@subjects = Subject.where(:name=>"Content").first
      @pages = Page.where(:subject_id=>4).visible.sorted
      if session[:user_id].present?
        @admin = AdminUser.find(session[:user_id])
        if params[:jkMxnas].present?
          @status = "Welcome Mr. #{@admin.name}"
        end
      else
        @admin 
      end
  end

end
