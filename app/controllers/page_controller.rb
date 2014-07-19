class PageController < ApplicationController
  
  layout "admin"
  
  before_action :confirm_login
  before_action :get_sub

  def index
    @pages=@subject.pages.sorted
  end

  def new
    @page = Page.new
    @page_count = Page.where(:subject_id=>@subject.id).count + 1
    @subjects = Subject.sorted
  end
  def create
    @page = Page.new(post_params)
    if @page.save
      flash[:notice] = "Successfully Created New Page"
      redirect_to(:action=>'index',:sub=>@subject.id)
    else
      flash[:notice] = "Error While Creating New Page"
      @page_count = Page.count
      @subjects = Subject.sorted
      redirect_to :action=>'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.sorted
    @page_count = Page.where(:subject_id=>@subject.id).count 
  end
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(post_params)
      flash[:notice] = "Successfully Update the Page"
      redirect_to :action=> 'show',:id=>@page.id,:sub=>@subject.id
    else
      flash[:notice] = "Error While updating Page"
      @page_count = Page.count
      @subjects = Subject.sorted
      render :action=>'edit',:id=>@page.id,:sub=>@subject.id
    end
  end
  

  def delete
    @page = Page.find(params[:id])
  end
  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:notice]="Delete the '#{@page.name}' Successfully"
      redirect_to :action=>'index',:sub=>@subject.id
    end
  end

  def show
    @page = Page.find(params[:id])
  end
  
  private
  def post_params
    params.require(:page).permit(:name,:position,:visible,:permalink,:subject_id)
  end

  def get_sub
    @subject = Subject.find(params[:sub])
  end
  
end
