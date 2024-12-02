class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]

  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def show
    @project = Project.find(params[:project_id])
    @items = @project.items

    @selected_benefits = @project.selected_benefits
    @benefit = Benefit.find(@selected_benefits.last)

    case @benefit.id
    when 1
      @project.picture = "1.freshfood.jpg"
    when 2
      @project.picture = "2.sustainability.jpg"
    when 3
      @project.picture = "3.air quality.jpg"
    when 4
      @project.picture = "4.balcony.jpg"
    when 5
      @project.picture = "18.shared projects.jpg"
    when 6
      @project.picture = "5.decoration.jpg"
    when 7
      @project.picture = "15.bonding activities.jpg"
    when 8
      @project.picture = "20.jpg"
    when 9
      @project.picture = "7.zen.jpg"
    when 10
      @project.picture = "8.seasonal.jpg"
    when 11
      @project.picture = "11.structural greenery.jpg"
    when 12
      @project.picture = "9.healthy eating.jpg"
    when 13
      @project.picture = "12.physical exercise.jpg"
    when 14
      @project.picture = "14.fresh air.jpg"
    when 15
      @project.picture = "13.stress relief.jpg"
    when 16
      @project.picture = "19.group activity.jpg"
    when 17
      @project.picture = "17.bonding activities.jpg"
    when 18
      @project.picture = "16.educational.jpg"
    when 19
      @project.picture = "10.shared project.jpg"
    when 20
      @project.picture = "6.full sun.jpg"
    end
  end

  def my_saved_projects
    @project = Project.find(params[:project_id])
    @project.user_id = current_user.id
    @project.save
    redirect_to project_results_path(@project)
    flash[:saved] = "Saved in your projects!"
  end

  def destroy
    @project = Project.find(params[:project_id])
    @project.destroy
    redirect_to projects_path
  end

end
