class PlayersController < ApplicationController
	def index
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



  end
end
