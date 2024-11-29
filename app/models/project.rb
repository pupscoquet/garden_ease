class Project < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo

  def content
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user",
                  content: "I'm a complete beginner to gardening.
                  I want a new gardening project that suits my space.

                  These are the qualities of my space: #{self.selected_spaces}
                  And I want to get this out of my project: #{self.selected_benefits}

                  I need the following for the project you suggest:
                  Name.
                  Standfirst.
                  Difficulty - between 1-5.
                  Duration of whole project. In either hours, days or weeks.
                  Description - ~80 words.
                  A broken down bulleted list of 1-7 items I would need.
                  A numbered list of the method - max 800 words, no headings.
                  A fun fact about it - max 20 words.

                  When generating the above, generate response in British
                  English and assume I don't know terms like 'proper drainage',
                  'trellis' or 'mulch' and that I'd need an explanation of how
                  to do things like sow seeds in pots. Leave out any special
                  characters like # and *.

                  I need this to be generated in a json format as follows:
                  {'project.id':[
                  { 'name':'your generated response',
                    'standfirst':'your generated response',
                    'difficulty':'your generated response as a bigint',
                    'duration':'your generated response',
                    'description':'your generated response',
                    'items':'your generated response',
                    'method':'your generated response',
                    'fact':'your generated response',
                   }
                  ]}
                  "}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    update(content: new_content)
    return new_content
  end



  # def content
  #   set_content ? super.blank? : super
  # end
end
