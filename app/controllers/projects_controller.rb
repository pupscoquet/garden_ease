class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def show
    @project = Project.find(params[:project_id])
    @items = @project.items

  end

  def my_saved_projects
    @project = Project.find(params[:project_id])
    @project.user_id = current_user.id
    @project.save
    redirect_to project_results_path(@project)
    flash[:saved] = "Saved in your projects!"
  end

end
