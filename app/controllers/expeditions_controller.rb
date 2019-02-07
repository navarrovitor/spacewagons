class ExpeditionsController < ApplicationController
  def new
    user = current_user
    @expeditions_left = user.exp_left

    @expedition_destinations = []
    5.times do
      @expedition_destinations << Destination.all.sample.name
    end
  end

  def create
    one_item_prob = 1
    two_item_prob = 0
    three_item_prob = 0
    part_damage_max = 40
    part_damage_min = 5
    gold_mult_min = 5
    gold_mult_max = 25

    user = User.find(params[:user_id])

    if user.exp_left > 0

      expedition = Expedition.new
      expedition.user_id = user.id
      expedition.destination = params[:destination_name]

      roll = rand()

      `rails db:seed:expedition_new_part`
      total_items = 1

      if (roll < 1 - two_item_prob)
        `rails db:seed:expedition_new_part`
        total_items = 2
      end

      if (roll < 1 - three_item_prob)
        `rails db:seed:expedition_new_part`
        total_items = 3
      end

      roll = rand()

      stat_acc = 0
      stat_spd = 0
      stat_man = 0
      stat_atk = 0
      stat_def = 0

      user.parts.select {|part| part.is_equiped}.each do |part|
        stat_acc += part.stat_acc
        stat_spd += part.stat_spd
        stat_man += part.stat_man
        stat_atk += part.stat_atk
        stat_def += part.stat_def
      end

      sum_stats = stat_acc + stat_spd + stat_man + stat_atk + stat_def

      gold = sum_stats * (gold_mult_min + (gold_mult_max - gold_mult_min)*rand()).round(0).to_i

      user.coins += gold
      expedition.gold_found = gold

      user.exp_left -= 1

      last_part_id = Part.last.id

      if total_items == 3

        expedition.expedition_item_1 = last_part_id - 2
        part = Part.find(expedition.expedition_item_1)
        part.user_id = user.id
        part.save
        expedition.expedition_item_2 = last_part_id - 1
        part = Part.find(expedition.expedition_item_2)
        part.user_id = user.id
        part.save
        expedition.expedition_item_3 = last_part_id
        part = Part.find(expedition.expedition_item_3)
        part.user_id = user.id
        part.save

      elsif total_items == 2
        expedition.expedition_item_1 = last_part_id - 1
        part = Part.find(expedition.expedition_item_1)
        part.user_id = user.id
        part.save
        expedition.expedition_item_2 = last_part_id
        part = Part.find(expedition.expedition_item_2)
        part.user_id = user.id
        part.save

      else
        expedition.expedition_item_1 = last_part_id
        part = Part.find(expedition.expedition_item_1)
        part.user_id = user.id
        part.save

      end

      user.parts.select { |part| part.is_equiped == true}.each do |part|
        part.condition -= part_damage_min + ((part_damage_max - part_damage_min)*rand()).round(0).to_i
        part.save
        if part.condition < 0
          part.destroy
        end
      end

      user.save
      expedition.save

      redirect_to expeditions_simulator_path

    else

      redirect_to new_expedition_path

    end
  end

  def simulator
    @expedition = Expedition.last

    @item1 = Part.find(@expedition.expedition_item_1)
    @it = 1

    if !@expedition.expedition_item_2.nil?
      @item2boo = true
      @item2 = Part.find(@expedition.expedition_item_2)
      @it += 1
    end
    if !@expedition.expedition_item_3.nil?
      @item3boo = true
      @item3 = Part.find(@expedition.expedition_item_3)
      @it += 1
    end

  end

end
