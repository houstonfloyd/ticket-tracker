class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  
  def index
    @projects = Project.all
  end  

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_url, notice: 'Your project was created.'
    else
      render :new
    end    
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_url(@project), notice: 'Project was updated'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was deleted.'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
