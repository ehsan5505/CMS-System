class SubjectController < ApplicationController
  
  layout "admin"
  
  before_action :confirm_login

  def index
    @subjects = Subject.sorted
  end

  def new
    @subject = Subject.new 
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(post_params)
    if @subject.save
      flash[:notice] = "Successfully create new Subject"
      redirect_to(:action=>'index')
    else
      @subject_count = Subject.count + 1
      render(:action=>'new')
    end
  end
  
  def edit
    @subject_count = Subject.count
    @subject = Subject.find(params[:id])
  end
  
  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(post_params)
	flash[:notice]="Update #{@subject.name} Successfully"
	redirect_to(:action=>'show',:id=>@subject.id)
    else
	@subject_count = Subject.count
	render(:action=>'edit',:id=>@subject.id)
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end
  
  def destroy
    @subject = Subject.find(params[:id])
    if @subject.destroy
      flash[:notice] = "Delete #{@subject.name} Successfully"
      redirect_to(:action=>'index')
    end
  end

  def show
    @subject = Subject.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:subject).permit(:name,:position,:visible)
  end
  
end
