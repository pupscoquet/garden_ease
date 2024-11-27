# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Benefit.destroy_all
puts "All benefits destroyed"
Space.destroy_all
puts "All spaces destroyed"
Project.destroy_all
puts "All projects destroyed"
User.destroy_all
puts "All users destroyed"

user = 0
project = 0
benefit = 0
space = 0

benefits_array = ["Fresh food",
  "Sustainability",
  "Air quality improvement",
  "Cost savings",
  "Self-reliance",
  "Decoration",
  "Privacy",
  "Space enhancement",
  "Zen spaces",
  "Seasonal colour",
  "Structural greenery",
  "Healthy eating",
  "Physical exercise",
  "Time outdoors",
  "Stress relief",
  "Fresh air",
  "Bonding activities",
  "Educational purposes",
  "Shared projects",
  "Group activity"]

spaces_array = ["Balcony",
  "Terrace",
  "Windowsill",
  "Interior",
  "Garden",
  "Full sun",
  "Partial shade",
  "Full shade",
  "North-facing",
  "South-facing",
  "Windy",
  "Dry",
  "Humid",
  "Frost-prone",
  "Tropical",
  "Rocky or uneven ground",
  "Raised beds or platforms",
  "Flat ground",
  "Portable container-friendly",
  "Water access"]

puts "Creating everything..."
20.times do
  last_user = User.create!(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: "123456"
              )
  puts "#{user = user + 1} users created"

  last_project = Project.create!(user: last_user,
    name: Faker::JapaneseMedia::StudioGhibli.movie,
    description: Faker::JapaneseMedia::StudioGhibli.quote,
    difficulty: rand(0..5),
    duration: "#{[0..10].sample} #{["days", "weeks", "months"].sample}")
  puts "#{project = project + 1} projects created"
end
puts "20 USERS & 20 PROJECTS CREATED"

20.times do
  Benefit.create!(type_of_benefit: benefits_array[benefit])
  puts "#{benefit = benefit + 1} benefits created"
end
puts "20 BENEFITS CREATED"

20.times do
  Space.create!(type_of_space: spaces_array[space])
  puts "#{space = space + 1} spaces created"
end
puts "20 SPACES CREATED"
