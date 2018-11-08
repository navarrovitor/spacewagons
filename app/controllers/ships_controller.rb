class ShipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.progress = 1
    user.coins = 10000
    user.save

    ship = Ship.new
    ship.name = params[:ship_name]
    ship.user_id = user.id
    ship.save

    redirect_to new_part_path
  end

  def show
  end

  def edit
  end

  def update
  end
end
