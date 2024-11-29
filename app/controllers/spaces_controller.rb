class SpacesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def new
    @project = Project.find(params[:project_id])
    @spaces = Space.all
  end

  def create
    @selected_spaces = Space.find(params[:selected_spaces])
    space_ids = @selected_spaces.map(&:id)
    @project = Project.find(params[:project_id])
    @project.selected_spaces = space_ids
    @project.save

    redirect_to project_results_path(@project)
  end

  private

  def space_params
    params.require(:space).permit(:selected_spaces[])
  end
end
