class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:project_id])
  end

  private

  def project_params
    params.require(:project).permit()
  end
end
