class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.new(params[:s_id])
    @project.create!
  end

  def show
    # @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit()
  end
end
