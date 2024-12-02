class Project < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo

  def set_content
    selected_benefits = []
    b_id = self.selected_benefits
    b_id.each do |benefit|
      selected_benefit = Benefit.find(benefit)
      benefit_string = selected_benefit.type_of_benefit
      selected_benefits << benefit_string
    end

    selected_spaces = []
    s_id = self.selected_spaces
    s_id.each do |space|
      selected_space = Space.find(space)

      space_string = selected_space.type_of_space
      selected_spaces << space_string
    end

    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user",
                  content: "I'm a complete beginner to gardening.
                  I want a new gardening project that suits my space.

                  These are the qualities of my space: #{selected_spaces}
                  And I want to get this out of my project: #{selected_benefits}
                  At the location: #{location}

                  I need the following for the project you suggest:
                  Name.
                  Standfirst.
                  Difficulty - between 1-5. Has to be above 0.
                  Duration - in either hours, days or weeks.
                  Description - ~80 words.
                  A broken down bulleted list of 1-7 items I would need, put a
                  '-' between each item.
                  A numbered list of the method - max 800 words, no headings,
                  put a '-' between each step.
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
                  / your generated response for duration like '1 week' or '2 months'
                  / your generated response for description
                  / your generated response for items
                  / your generated response for method
                  / your generated response for fun fact
                  "}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    split_content = new_content.split('/')
    # items =
    # method =

    self.name = split_content[1]
    self.description = split_content[5]
    self.difficulty = split_content[3]
    self.duration = split_content[4]
    self.standfirst = split_content[2]
    self.items = split_content[6]
    self.method = split_content[7]
    self.fact = split_content[8]
    self.save

    selected_array = []
    selected_array << selected_benefits
    selected_array << selected_spaces
    return selected_array
  end

  # def description
  #   if super.blank?
  #     set_content
  #  else
  #     super
  #   end
  # end
end
