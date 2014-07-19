class SectionController < ApplicationController

  layout "admin"
  
  before_action :confirm_login
  before_action :get_nested
  
  def index
    @sections = @page.sections.sorted
  end

  def new
    @section = Section.new
    @section_count = Section.where(:page_id=>@page.id).sorted.count + 1
    @pages = Page.sorted
  end
  
  def create
    @section = Section.new(post_params)
    if @section.save
      flash[:notice]="#{@section.name} is Created Successfully"
      redirect_to(:action=>'show',:id=>@section.id,:pg=>@page.id,:sub=>@subject.id)
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render :action=>'new',:pg=>@page.id,:sub=>@subject.id
    end
  end

  def show
    @section = Section.find(params[:id])
  end

  def delete
    @section = Section.find(params[:id])
  end
  
  def destroy
    @section = Section.find(params[:id])
    if @section.destroy
      flash[:notice] = "Delete #{@section.name} is Successfully"
      redirect_to :action=>'index',:pg=>@page.id,:sub=>@subject.id
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.where(:page_id=>@page.id).count
    @pages = Page.sorted
  end
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(post_params)
      flash[:notice] ="Edit the #{@section.name} is Successfully"
      redirect_to :action=>'show', :id=>@section.id,:pg=>@page.id,:sub=>@subject.id
    else
      flash[:notice] = "Error in Editing the section"
      @section_count = Section.count
      @pages = Page.sorted
      render :action=> 'edit',:id =>@section.id,:pg=>@page.id,:sub=>@subject.id
    end
  end
  
  private
  def post_params
    params.require(:section).permit(:name,:position,:visible,:content_type,:content,:page_id,:permalink)
  end
  

  def get_nested
    if params[:sub].present? && params[:pg].present?
      @subject =  Subject.find(params[:sub])
      @page   =   Page.find(params[:pg])  
    end
  end 

end
