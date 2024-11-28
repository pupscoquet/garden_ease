class SpacesController < ApplicationController
  def new
    @spaces = Space.all
  end

  def create
    @selected_spaces = Space.find(params[:selected_spaces])
    space_ids = @selected_spaces.map(&:id)
    benefit_ids = params[:b_id]
    redirect_to url_for(controller: 'projects', action: 'show', b_id: benefit_ids, s_id: space_ids)
  end

  private

  def space_params
    params.require(:space).permit(:selected_spaces[])
  end
end
