class Project < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo

  def set_content
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

                  I need this to be generated as follows:
                  / your generated response for name
                  / your generated response for standfirst
                  / your generated response for difficulty
                  / your generated response for duration
                  / your generated response for description
                  / your generated response for items
                  / your generated response for method
                  / your generated response for fun fact
                  "}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    split_content = new_content.split('/')

    self.name = split_content[1]
    self.description = split_content[2]
    self.difficulty = split_content[3]
    self.duration = split_content[4]

    update(content: new_content)
    return split_content
  end


  def content
    if super.blank?
      set_content
    else
      super
    end
  end
end
