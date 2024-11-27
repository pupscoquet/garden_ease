class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Give me a 3 or 4 lines gardening project description for #{@project.name} with the criterias little balcony, sunny all year. Then give me a list of 3 or 4 plants or seeds I would need and the steps to follow for each plant to take car of them (when to water...).Give me only the text of the project, without any of your own answer like 'Here is a simple recipe'."}]
    })
    @content = chatgpt_response["choices"][0]["message"]["content"]
  end
end
