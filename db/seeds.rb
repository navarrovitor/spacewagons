# Seed the basic parts

# Basic propulsion
Part.new
Part.create
Part.last.type = "propulsor"
Part.last.condition = 100
Part.last.stat_acc =
Part.last.stat_spd =
Part.last.stat_man =
Part.last.stat_atk =
Part.last.stat_def =
Part.last.for_scale = false
Part.last.user_id = 1
Part.last.serial =


create_table "parts", force: :cascade do |t|
    t.string "serial"
    t.string "type"
    t.integer "condition"
    t.integer "price"
    t.integer "stat_acc"
    t.integer "stat_spd"
    t.integer "stat_man"
    t.integer "stat_atk"
    t.integer "stat_def"
    t.boolean "for_sale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_parts_on_user_id"
  end
puts "Created ingredient: campari".blue
sleep(0.1)

# Basic shell


# Basic shield


# Basic bumpers


# Basic wings
