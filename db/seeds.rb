# Seed the basic parts

part = Part.new
part.category = "propulsor"
part.condition = 100
part.stat_acc = 17
part.stat_spd = 9
part.stat_man = -1
part.stat_atk = 0
part.stat_def = 0
part.for_sale = true
part.user_id = 1
part.serial = "PROP-BUÇA-037"
part.is_starter = true
part.initial_price = 2000
part.price = 2000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "shell"
part.condition = 100
part.stat_acc = 17
part.stat_spd = 9
part.stat_man = -1
part.stat_atk = 0
part.stat_def = 0
part.for_sale = true
part.user_id = 1
part.serial = "SHLL-PEDRANAVESICULA-212"
part.is_starter = true
part.initial_price = 3000
part.price = 3000
part.save
puts "Created part #{part.serial}"

part = Part.new
part.category = "bumper"
part.condition = 100
part.stat_acc = 17
part.stat_spd = 9
part.stat_man = -1
part.stat_atk = 0
part.stat_def = 0
part.for_sale = true
part.user_id = 1
part.serial = "BMPR-TROMBADINHA-935"
part.is_starter = true
part.initial_price = 2000
part.price = 2000
part.save
puts "Created part #{part.serial}"
