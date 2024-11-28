class SpacesController < ApplicationController
  def new
    @spaces = Space.all
  end

  def create
    @selected_spaces = Space.find(params[:selected_spaces])
    space_ids = @selected_spaces.map(&:id)
    @project = Project.find_by_session_token(session[:session_token])
    @project.selected_spaces = space_ids

    redirect_to url_for(controller: 'projects', action: 'show')
  end

  private

  def space_params
    params.require(:space).permit(:selected_spaces[])
  end
end
