# Seed the basic parts

def random_var(var)
  return -var + rand(2*var+1)
end

def build_part(user,type,qual)

  if (type == 'propulsor' && qual == 1)
  # Basic propulsion:
  part = Part.new
  part.category = "propulsor"
  part.condition = 100
  part.stat_acc = 4 + random_var(2)
  part.stat_spd = 2 + random_var(2)
  part.stat_man = -2 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "PROP-QUK-001"
  part.is_starter = true
  part.initial_price = 1000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'propulsor' && qual == 2)
  part = Part.new
  part.category = "propulsor"
  part.condition = 100
  part.stat_acc = 8 + random_var(2)
  part.stat_spd = 8 + random_var(2)
  part.stat_man = -3 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "PROP-QKS-002"
  part.is_starter = true
  part.initial_price = 2000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'propulsor' && qual == 3)
  part = Part.new
  part.category = "propulsor"
  part.condition = 100
  part.stat_acc = 10 + random_var(2)
  part.stat_spd = 8 + random_var(2)
  part.stat_man = -1 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "PROP-TPR-003"
  part.is_starter = true
  part.initial_price = 3000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shell' && qual == 1)
  # Basic shell
  part = Part.new
  part.category = "shell"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 5 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 5 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLL-BAS-001"
  part.is_starter = true
  part.initial_price = 1000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shell' && qual == 2)
  part = Part.new
  part.category = "shell"
  part.condition = 100
  part.stat_acc = -2 + random_var(2)
  part.stat_spd = 10 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 10 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLL-SMX-002"
  part.is_starter = true
  part.initial_price = 2000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shell' && qual == 3)
  part = Part.new
  part.category = "shell"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 2 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 20 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLL-LGT-003"
  part.is_starter = true
  part.initial_price = 3000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shield' && qual == 1)
  # Basic shield
  part = Part.new
  part.category = "shield"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 0 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 10 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLD-BAS-001"
  part.is_starter = true
  part.initial_price = 1000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shield' && qual == 2)
  part = Part.new
  part.category = "shield"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 0 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 15 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLD-HVY-002"
  part.is_starter = true
  part.initial_price = 2000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'shield' && qual == 3)
  part = Part.new
  part.category = "shield"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 0 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 20 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "SHLD-CTR-003"
  part.is_starter = true
  part.initial_price = 3000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'bumper' && qual == 1)
  # Basic bumpers
  part = Part.new
  part.category = "bumper"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 2 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 5 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "BMPR-BAS-001"
  part.is_starter = true
  part.initial_price = 1000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'bumper' && qual == 2)
  part = Part.new
  part.category = "bumper"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 5 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 10 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "BMPR-HVY-002"
  part.is_starter = true
  part.initial_price = 2000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'bumper' && qual == 3)
  part = Part.new
  part.category = "bumper"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 8 + random_var(2)
  part.stat_man = 0 + random_var(2)
  part.stat_atk = 15 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "BMPR-BAL-003"
  part.is_starter = true
  part.initial_price = 3000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'wing' && qual == 1)
  # Basic wings
  part = Part.new
  part.category = "wing"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 8 + random_var(2)
  part.stat_man = 8 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "WING-SPD-001"
  part.is_starter = true
  part.initial_price = 1000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'wing' && qual == 2)
  part = Part.new
  part.category = "wing"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 11 + random_var(2)
  part.stat_man = 11 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "WING-BAL-002"
  part.is_starter = true
  part.initial_price = 2000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end

  if (type == 'wing' && qual == 3)
  part = Part.new
  part.category = "wing"
  part.condition = 100
  part.stat_acc = 0 + random_var(2)
  part.stat_spd = 14 + random_var(2)
  part.stat_man = 14 + random_var(2)
  part.stat_atk = 0 + random_var(2)
  part.stat_def = 0 + random_var(2)
  part.for_sale = false
  part.user_id = user.id
  part.serial = "WING-MNV-003"
  part.is_starter = true
  part.initial_price = 3000
  part.is_equiped = true
  part.save
  puts "Created part #{part.serial}"
  end
end


# Delete all current parts equipped
Part.all.select{|part| part.is_equiped}.each do |part|
  part.destroy
end

types = ['propulsor', 'shield', 'wing', 'bumper', 'shell']
quals = [1,2,3]
User.all.each do |user|
  types.each do |type|
    if (user.username == "Musk")
      build_part(user,type,3)
    else
      build_part(user,type,quals.sample)
    end

    p "Created #{Part.last} for #{user.username}"
  end
end

p "Finished"
