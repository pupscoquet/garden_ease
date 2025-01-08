class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :generate ]

  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def show
    @projects = Project.all
    @project = Project.find(params[:project_id])
    @items = @project.items

    @project = Project.find(params[:project_id])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user",
                  content: "I need 10 garden centres
                  within a 10 mile radius of #{@project.location}.

                  I need the following for each garden centre:
                  Name.
                  Address.
                  Latitude.
                  Longitude.
                  Add a '*' at the end of each garden centre. Do not add an intro
                  nor a conclusion or summary. Just the info above. Do not make
                  it into a numbered list.

                  I need this to be generated as follows:
                  name /
                  address /
                  latitude /
                  longitude"
                  }]
    })

    garden_centres = chatgpt_response["choices"][0]["message"]["content"]
    split_centres = garden_centres.split('*')

    one = split_centres[0].split('/').map(&:strip)
    two = split_centres[1].split('/').map(&:strip)
    three = split_centres[2].split('/').map(&:strip)
    four = split_centres[3].split('/').map(&:strip)
    five = split_centres[4].split('/').map(&:strip)
    six = split_centres[5].split('/').map(&:strip)
    seven = split_centres[6].split('/').map(&:strip)
    eight = split_centres[7].split('/').map(&:strip)
    nine = split_centres[8].split('/').map(&:strip)
    ten = split_centres[9].split('/').map(&:strip)

    Florist.create!(name: one[0], address: one[1], longitude: one[3], latitude: one[2])
    Florist.create!(name: two[0], address: two[1], longitude: two[3], latitude: two[2])
    Florist.create!(name: three[0], address: three[1], longitude: three[3], latitude: three[2])
    Florist.create!(name: four[0], address: four[1], longitude: four[3], latitude: four[2])
    Florist.create!(name: five[0], address: five[1], longitude: five[3], latitude: five[2])
    Florist.create!(name: six[0], address: six[1], longitude: six[3], latitude: six[2])
    Florist.create!(name: seven[0], address: seven[1], longitude: seven[3], latitude: seven[2])
    Florist.create!(name: eight[0], address: eight[1], longitude: eight[3], latitude: eight[2])
    Florist.create!(name: nine[0], address: nine[1], longitude: nine[3], latitude: nine[2])
    Florist.create!(name: ten[0], address: ten[1], longitude: ten[3], latitude: ten[2])

    # map
    @florists = Florist.near([@project.latitude, @project.longitude], 10).geocoded
    @markers = @projects.geocoded.map do |project|      {
        lat: @project.latitude,
        lng: @project.longitude
      }
    end

    @markers += @florists.geocoded.map do |florist|
      {
        lat: florist.latitude,
        lng: florist.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {florist: florist}),
        marker_html: render_to_string(partial: "marker")
      }
    end

    # pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "GardenEase-#{@project.name}", template: 'projects/pdf', locals: { project: @project }, formats: [:html], no_background: true
      end
    end
  end

  def generate
    @project = Project.find(params[:project_id])
    @project.set_content
    redirect_to project_results_path(@project)
  end

  def my_saved_projects
    @project = Project.find(params[:project_id])
    @project.user_id = current_user.id
    @project.save
    redirect_to project_results_path(@project)
    flash[:saved] = "Saved in your projects!"
  end

  def pdf
    @project = Project.find(params[:project_id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:project_id)
  end
end
