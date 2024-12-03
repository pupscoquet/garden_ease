class Project < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo
  attribute :items, :json, default: []
  attribute :method, :json, default: []
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def set_content
    selected_array = []
    selected_benefits = []
    selected_spaces = []

    b_id = self.selected_benefits
    b_id.each do |benefit|
      selected_benefit = Benefit.find(benefit)
      benefit_string = selected_benefit.type_of_benefit
      selected_benefits << benefit_string
    end

    s_id = self.selected_spaces
    s_id.each do |space|
      selected_space = Space.find(space)

      space_string = selected_space.type_of_space
      selected_spaces << space_string
    end

    selected_array << selected_benefits
    selected_array << selected_spaces

    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user",
                  content: "I'm a complete beginner to gardening.
                  I want a new gardening project that suits my space.

                  These are the qualities of my space: #{selected_spaces}
                  And I want to get this out of my project: #{selected_benefits}
                  Take into account the climate here: #{location}

                  I need the following for the project you suggest:
                  Name.
                  Standfirst.
                  Difficulty - between 1-5. Has to be above 0.
                  Duration - in either hours, days or weeks.
                  Description - ~80 words. Mention the location (#{location}) here.
                  A broken down bulleted list of 1-10 items I would need, put a
                  '|' between each item.
                  An unordered list of the method - max 1000 words, no headings,
                  put a '|' between each step.
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

    items = split_content[6]
    split_items = items.split('|').map(&:strip)
    method = split_content[7]
    split_method = method.split('|').map(&:strip)

    self.name = split_content[1]
    self.description = split_content[5]
    self.difficulty = split_content[3]
    self.duration = split_content[4]
    self.standfirst = split_content[2]
    self.items = split_items
    self.method = split_method
    self.fact = split_content[8]
    self.save


    return items
  end

  def description
    if super.blank?
      set_content
   else
      super
    end
  end

  def picture
    benefit = Benefit.find(selected_benefits.last)

    case benefit.id
    when 1 || 21
      "1.freshfood.jpg"
    when 2 || 22
      "2.sustainability.jpg"
    when 3 || 23
      "3.air quality.jpg"
    when 4 || 24
      "4.balcony.jpg"
    when 5 || 25
      "18.shared projects.jpg"
    when 6 || 26
      "5.decoration.jpg"
    when 7 || 27
      "15.bonding activities.jpg"
    when 8 || 28
      "20.jpg"
    when 9 || 29
      "7.zen.jpg"
    when 10 || 30
      "8.seasonal.jpg"
    when 11 || 31
      "11.structural greenery.jpg"
    when 12 || 32
      "9.healthy eating.jpg"
    when 13 || 33
      "12.physical exercise.jpg"
    when 14 || 34
      "14.fresh air.jpg"
    when 15 || 35
      "13.stress relief.jpg"
    when 16 || 36
      "19.group activity.jpg"
    when 17 || 37
      "17.time outdoors.jpg"
    when 18 || 38
      "16.educational.jpg"
    when 19 || 39
      "10.shared project.jpg"
    when 20 || 40
      "6.full sun.jpg"
    end
  end

end
