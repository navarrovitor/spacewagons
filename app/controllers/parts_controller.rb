class PartsController < ApplicationController


  def index
    @parts_for_sale = Part.where(for_sale: true).select {|part| part.user_id != current_user.id}

  end

  def show
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

  def evaluate
    raise

    # click to evaluate for salvage
    # get method
    # render the value of the piece based on stats and condition
    # has a button to click to accept the value
  end

  def salvage

    # actually sell the piece
    # destroy method
    # adds coins equal to the value you agreed on last instance
  end


  def sell
    # get method
    # prompt for price you want to sell
    # confirmation to put for sale
  end

  def put_in_marketplace
    # patch method: update for_sale and price
    # update price
    # update
  end


  private

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
