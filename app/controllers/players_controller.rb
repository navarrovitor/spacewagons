class PlayersController < ApplicationController
	def index
		@users = User.all
	end
end
