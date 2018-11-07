class PartsController < ApplicationController
  def index
    @parts_for_sale = Part.where(for_sale: true)
  end

  def show
  end

  def transact
    # user = current_user



    # user.coins -=

  end



  private

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def transaction
  end

  def destroy
  end
end
