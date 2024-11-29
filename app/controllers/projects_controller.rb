class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def index
    @projects = Project.where(user_id: current_user.id)
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

  def my_saved_projects
    @project = Project.find(params[:project_id])
    @project.user_id = current_user.id
    @project.save
    redirect_to project_results_path(@project)
    flash[:saved] = "Saved in your projects!"
  end

end
