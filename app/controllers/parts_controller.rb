class PartsController < ApplicationController


  def index
    @parts_for_sale = Part.where(for_sale: true).select {|part| part.user_id != current_user.id}
  end

  def show
  end

  def new
    @user = current_user
    # Initiate the 15 basic parts to be sold to the user
    `rails db:seed:boardin-basic-parts`
    # Pick the 15 last generated parts to be the user basic parts
    @basicparts = Part.all[-15 .. -1]

    @basicpartsids = []
    @basicparts.each do |part|
      @basicpartsids << part.id
    end
  end

  def create
    user = User.find(params[:user_id])

    # Transfer each part from neutral user to the user
    used_parts = []

    part_prop = Part.find(params[:prop_id])
    part_prop.user_id = user.id
    part_prop.is_equiped = true
    part_prop.rarity = "Common"
    part_prop.save
    used_parts << part_prop

    part_shield = Part.find(params[:shield_id])
    part_shield.user_id = user.id
    part_shield.is_equiped = true
    part_shield.rarity = "Common"
    part_shield.save
    used_parts << part_shield

    part_shell = Part.find(params[:shell_id])
    part_shell.user_id = user.id
    part_shell.is_equiped = true
    part_shell.rarity = "Common"
    part_shell.save
    used_parts << part_shell

    part_bumper = Part.find(params[:bumper_id])
    part_bumper.user_id = user.id
    part_bumper.is_equiped = true
    part_bumper.rarity = "Common"
    part_bumper.save
    used_parts << part_bumper

    part_wing = Part.find(params[:wing_id])
    part_wing.user_id = user.id
    part_wing.is_equiped = true
    part_wing.rarity = "Common"
    part_wing.save
    used_parts << part_wing

    # Destroy all unused parts

    all_parts = params[:all_parts].split(" ")
    all_parts.map!(&:to_i)

    unused_parts = all_parts.select { |part| !used_parts.include?(Part.find(part)) }

    unused_parts.each do |part|
      unused_part = Part.find(part)
      unused_part.destroy
    end

    # Update user status

    user.progress = 2
    user.coins = 0
    user.save

    redirect_to player_path(user.id)
  end

  # transact
  def transaction

    buyer = User.find(params[:buyer_id])
    part = Part.find(params[:part_id])
    seller = User.find(part.user_id)

    if buyer.coins > part.price

      part.user_id = buyer.id

      buyer.coins -= part.price
      seller.coins += part.price

      part.for_sale = false
      part.price = 0

      part.save
      buyer.save
      seller.save

      redirect_to parts_path
    else
      redirect_to parts_path
    end
  end

  def sell
    @part = Part.find(params[:id])

    @salvage_value = 0
    @salvage_value += @part.stat_acc
    @salvage_value += @part.stat_spd
    @salvage_value += @part.stat_man
    @salvage_value += @part.stat_atk
    @salvage_value += @part.stat_def
    @salvage_value *= 30
    @salvage_value *= @part.condition/100

    @salvage_value = 3*@part.condition if @salvage_value < 300

    @user = current_user.id
    # get method
    # prompt for price you want to sell
    # confirmation to put for sale
  end

  def salvage
    salvage_value = params[:salvage_value].to_i
    part = Part.find(params[:part_id])
    user = User.find(params[:salvage_user])


    if ( part.for_sale == true )

      part.destroy
      user.coins += salvage_value

      user.save

      redirect_to root_path

    else

      redirect_to root_path

    end
  end

  def put_in_marketplace
    sell_value = params[:sell_value]

    if sell_value !~ /\D/

      part = Part.find(params[:part_id])

      part.for_sale = true
      part.price = sell_value.to_i
      part.save

      redirect_to root_path

    else

      redirect_to parts_sell_path(params[:part.id])
    end
  end

  def remove_from_marketplace
    part = Part.find(params[:part_id])

    part.for_sale = false
    part.save

    redirect_to root_path
  end


  def equip
    part = Part.find(params[:part_id])
    user = User.find(part.user_id)


    if current_user.id == user.id

      currently_equiped = user.parts.select { |equiped| equiped.category == part.category && equiped.is_equiped == true}.first

      currently_equiped.is_equiped = false
      part.is_equiped = true

      currently_equiped.save
      part.save

      redirect_to player_path(user.id)

    else

      redirect_to player_path(user.id)

    end

  end

  private

  def edit
  end

  def destroy
  end
end
