part = Part.new

common_prob = 0.65
rare_prob = 0.25
unique_prop = 1 - common_prob - rare_prob
rarity_common_mult = 1
rarity_rare_mult = 3
rarity_unique_mult = 6

possible_categories = ["propulsor", "shield", "shell", "bumper", "wing"]
part.category = possible_categories.sample

part.save

part.serial = ""
if part.category == "propulsor"
  part.serial += "PROP-"
elsif part.category == "shield"
  part.serial += "SHLD-"
elsif part.category == "shell"
  part.serial += "SHEL-"
elsif part.category == "bumper"
  part.serial += "BMPR-"
else
  part.serial += "WING-"
end

4.times do
  part.serial += ('A'..'Z').to_a.sample
end
part.serial += "-"

3.times do
  part.serial += (0..9).to_a.sample.to_s
end

part.condition = 100

part.price = nil

rarity = rand()

if (rarity >= 0 && rarity < common_prob)
  part.rarity = "Common"
  raritymult = rarity_common_mult
elsif (rarity >= common_prob && rarity < common_prob + rare_prob)
  part.rarity = "Rare"
  raritymult = rarity_rare_mult
else
  part.rarity = "Unique"
  raritymult = rarity_unique_mult
end

if part.category == "propulsor"
  part.stat_acc = ((1..15).to_a.sample.to_f * raritymult).round(0)
  part.stat_spd = ((1..5).to_a.sample.to_f * raritymult).round(0)
  part.stat_man = ((-10..-1).to_a.sample.to_f / raritymult).round(0)
  part.stat_atk = 0
  part.stat_def = 0
elsif part.category == "shield"
  part.stat_acc = 0
  part.stat_spd = 0
  part.stat_man = 0
  part.stat_atk = 0
  part.stat_def = ((1..20).to_a.sample.to_f * raritymult).round(0)
elsif part.category == "shell"
  roll = (-5..5).to_a.sample.to_f
  if (roll <= 0)
    part.stat_acc = (roll / raritymult).round(0)
  else
    part.stat_acc = (roll * raritymult).round(0)
  end
  roll = (-5..5).to_a.sample.to_f
  if (roll <= 0)
    part.stat_spd = (roll / raritymult).round(0)
  else
    part.stat_spd = (roll * raritymult).round(0)
  end
  part.stat_man = 0
  part.stat_atk = 0
  part.stat_def = ((5..10).to_a.sample.to_f * raritymult).round(0)
elsif part.category == "bumper"
  part.stat_acc = 0
  part.stat_spd = 0
  part.stat_man = 0
  part.stat_atk = ((1..20).to_a.sample.to_f * raritymult).round(0)
  part.stat_def = 0
else
  part.stat_acc = 0
  part.stat_spd = ((1..15).to_a.sample.to_f * raritymult).round(0)
  part.stat_man = ((1..15).to_a.sample.to_f * raritymult).round(0)
  part.stat_atk = 0
  part.stat_def = 0
end

part.is_starter = false
part.initial_price = 0
part.is_equiped = false
part.for_sale = false

part.user_id = 1

part.save

puts "Generated new part"
puts "Name: #{part.serial}"
puts "Category: #{part.category}"
puts "Rarity: #{part.rarity}"
puts "Acceleration: #{part.stat_acc}"
puts "Speed: #{part.stat_spd}"
puts "Maneuvrability: #{part.stat_man}"
puts "Attack: #{part.stat_atk}"
puts "Defense: #{part.stat_def}"



