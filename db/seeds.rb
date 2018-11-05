# Seed the basic parts

# Basic propulsion
part = Part.new
part.category = "propulsor"
part.condition = 100
part.stat_acc = 12
part.stat_spd = 7
part.stat_man = -2
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "PROP-QUK-001"
part.is_starter = true
part.initial_price = 1000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "propulsor"
part.condition = 100
part.stat_acc = 17
part.stat_spd = 9
part.stat_man = -1
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "PROP-QKS-002"
part.is_starter = true
part.initial_price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "propulsor"
part.condition = 100
part.stat_acc = 23
part.stat_spd = 10
part.stat_man = 0
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "PROP-TPR-003"
part.is_starter = true
part.initial_price = 3000
part.save
puts "Created part #{part.serial}"

# Basic shell
part = Part.new
part.category = "shell"
part.condition = 100
part.stat_acc = -2
part.stat_spd = -1
part.stat_man = 2
part.stat_atk = 0
part.stat_def = 11
part.for_sale = false
part.user_id = 1
part.serial = "SHLL-BAS-001"
part.is_starter = true
part.initial_price = 1000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "shell"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 4
part.stat_man = 1
part.stat_atk = 0
part.stat_def = 13
part.for_sale = false
part.user_id = 1
part.serial = "SHLL-SMX-002"
part.is_starter = true
part.initial_price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "shell"
part.condition = 100
part.stat_acc = 4
part.stat_spd = 8
part.stat_man = 8
part.stat_atk = 0
part.stat_def = 8
part.for_sale = false
part.user_id = 1
part.serial = "SHLL-LGT-003"
part.is_starter = true
part.initial_price = 3000
part.save
puts "Created part #{part.serial}"


# Basic shield
part = Part.new
part.category = "shield"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 0
part.stat_man = 0
part.stat_atk = 0
part.stat_def = 15
part.for_sale = false
part.user_id = 1
part.serial = "SHLD-BAS-001"
part.is_starter = true
part.initial_price = 1000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "shield"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 0
part.stat_man = 2
part.stat_atk = 0
part.stat_def = 23
part.for_sale = false
part.user_id = 1
part.serial = "SHLD-HVY-002"
part.is_starter = true
part.initial_price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "shield"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 0
part.stat_man = 0
part.stat_atk = 12
part.stat_def = 20
part.for_sale = false
part.user_id = 1
part.serial = "SHLD-CTR-003"
part.is_starter = true
part.initial_price = 3000
part.save
puts "Created part #{part.serial}"


# Basic bumpers
part = Part.new
part.category = "bumper"
part.condition = 100
part.stat_acc = -6
part.stat_spd = -2
part.stat_man = -6
part.stat_atk = 12
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "BMPR-BAS-001"
part.is_starter = true
part.initial_price = 1000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "bumper"
part.condition = 100
part.stat_acc = -10
part.stat_spd = -8
part.stat_man = -10
part.stat_atk = 25
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "BMPR-HVY-002"
part.is_starter = true
part.initial_price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "bumper"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 0
part.stat_man = 0
part.stat_atk = 15
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "BMPR-BAL-003"
part.is_starter = true
part.initial_price = 3000
part.save
puts "Created part #{part.serial}"

# Basic wings
part = Part.new
part.category = "wing"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 16
part.stat_man = -4
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "WING-SPD-001"
part.is_starter = true
part.initial_price = 1000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "wing"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 12
part.stat_man = 8
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "WING-BAL-002"
part.is_starter = true
part.initial_price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "wing"
part.condition = 100
part.stat_acc = 0
part.stat_spd = 10
part.stat_man = 20
part.stat_atk = 0
part.stat_def = 0
part.for_sale = false
part.user_id = 1
part.serial = "WING-MNV-003"
part.is_starter = true
part.initial_price = 3000
part.save
puts "Created part #{part.serial}"
