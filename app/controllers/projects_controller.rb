class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new(selected_benefits[:selected_benefits],
                            selected_spaces[:selected_spaces])
  end

  def show
    # @project = Project.find(params[:id])
  end
end
