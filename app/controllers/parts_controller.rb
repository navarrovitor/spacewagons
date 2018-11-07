class PartsController < ApplicationController
  respond_to :js, :html


  def index
    @parts_for_sale = Part.where(for_sale: true)
  end

  def show
  end

  def transact
    raise

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
