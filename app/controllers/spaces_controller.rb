class SpacesController < ApplicationController
  def new
    @spaces = Space.all
  end

  def create
    @selected_spaces = Space.find(params[:selected_spaces])
    redirect_to '#'
  end

  private

  def space_params
    params.require(:space).permit(:selected_spaces[])
  end
end
