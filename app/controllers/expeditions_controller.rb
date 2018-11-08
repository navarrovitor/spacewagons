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
    user = User.find(params[:user_id])

    if user.exp_left > 0

      expedition = Expedition.new
      expedition.user_id = user.id
      expedition.destination = params[:destination_name]

      roll = rand()

      `rails db:seed:expedition_new_part`
      total_items = 1

      if (roll > 0.5)
        `rails db:seed:expedition_new_part`
        total_items = 2
      end

      if (roll > 0.8)
        `rails db:seed:expedition_new_part`
        total_items = 3
      end

      roll = rand()

      if (roll >= 0 && roll < 0.6)
        gold = (1000..2000).to_a.sample
      elsif (roll >= 0.6 && roll < 0.9)
        gold = (2000..3000).to_a.sample
      else
        gold = (3000..4000).to_a.sample
      end

      user.coins += gold
      expedition.gold_found = gold

      user.exp_left -= 1

      last_part_id = Part.last.id

      if total_items == 3

        expedition.expedition_item_1 = last_part_id - 2
        part = Part.find(last_part_id - 2)
        part.user_id = user.id
        part.save
        expedition.expedition_item_2 = last_part_id - 1
        part = Part.find(last_part_id - 1)
        part.user_id = user.id
        part.save
        expedition.expedition_item_3 = last_part_id
        part = Part.find(last_part_id)
        part.user_id = user.id
        part.save

      elsif total_items == 2
        expedition.expedition_item_1 = last_part_id - 1
        part = Part.find(last_part_id - 1)
        part.user_id = user.id
        part.save
        expedition.expedition_item_2 = last_part_id
        part = Part.find(last_part_id)
        part.user_id = user.id
        part.save

      else
        expedition.expedition_item_1 = last_part_id
        part = Part.find(last_part_id)
        part.user_id = user.id
        part.save

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
