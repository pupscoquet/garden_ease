class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:project_id])
  end

  def location
    @project = Project.find(params[:project_id]) #find the project by id
    @project.update(location: params[:location]) #update and save it on the db
  end

  private

  def project_params
    params.require(:project).permit()
  end
end
