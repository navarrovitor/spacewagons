require 'faker'

1000.times do

  destination = Destination.new

  destination.name = ""
  destination.name += "Galaxy: " + Faker::StarWars.planet
  destination.name += ", Sector: " + (1..999).to_a.sample.to_s
  destination.name += ", Planet: " + Faker::StarTrek.location

  destination.save

  puts "generated destination #{destination.name}"
end
