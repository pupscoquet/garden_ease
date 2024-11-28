class BenefitsController < ApplicationController
  def new
    @benefits = Benefit.all
  end


  def create
    @selected_benefits = Benefit.find(params[:selected_benefits])
    benefit_ids = @selected_benefits.map(&:id)
    @project = Project.new
    @project.selected_benefits = benefit_ids

    session[:project_id] = @project.id
    redirect_to spaces_path
  end

  private

  def benefit_params
    params.require(:benefit).permit(:selected_benefits[])
  end
end
