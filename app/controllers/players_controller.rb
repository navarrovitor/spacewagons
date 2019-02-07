class PlayersController < ApplicationController
	def index
    # Get all users minus the NPC (Jabba)
		@users = User.all
	end

  def show
    @user = User.find(params[:id])
    @equiped_parts = @user.parts.select { |part| part.is_equiped }
    @unequiped_parts = @user.parts.select { |part| !part.is_equiped }

    @user_ranking = User.all.order("score DESC").index(@user) + 1

    @ship_acc = 0
    @equiped_parts.each do |part|
      @ship_acc += part.stat_acc
    end
    @ship_spd = 0
    @equiped_parts.each do |part|
      @ship_spd += part.stat_spd
    end
    @ship_man = 0
    @equiped_parts.each do |part|
      @ship_man += part.stat_man
    end
    @ship_atk = 0
    @equiped_parts.each do |part|
      @ship_atk += part.stat_atk
    end
    @ship_def = 0
    @equiped_parts.each do |part|
      @ship_def += part.stat_def
    end

    last_race = Race.last
    @race_ok = !last_race.nil?
    if @race_ok
      @last_race_no_users = Race.last.runners.length
      @last_race_standing = last_race.final_results.sort.reverse.index(last_race.final_results[last_race.runners.index(@user.id)]) + 1
      @last_race_date = last_race.created_at.strftime("%d/%m/%y")
    end
  end

  def edit
    @player = current_user
  end

  def update
    raise
    user = User.find(current_user)
  end
end
