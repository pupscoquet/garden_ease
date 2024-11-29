class LocationController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id]) #find the project by id
    @project.update(location: params[:location]) #update and save it on the db
    redirect_to project_results_path(@project)
  end
end
