class PlayersController < ApplicationController
	def index
		@users = User.all
	end

  def show
    @user = User.find(params[:id])
    @equiped_parts = @user.parts.select { |part| part.is_equiped }
    @unequiped_parts = @user.parts.select { |part| !part.is_equiped }
  end
end
