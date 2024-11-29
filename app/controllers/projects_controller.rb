class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:project_id])

    # @selected_benefits = []
    # b_id = @project.selected_benefits
    # b_id.each do |benefit|
    #   @selected_benefit = Benefit.find(benefit)
    #   @benefit_string = @selected_benefit.type_of_benefit
    #   @selected_benefits << @benefit_string
    # end

    s_id = @project.selected_spaces
  end

  private

  def project_params
    params.require(:project).permit()
  end
end
