class TestController < ApplicationController
  def dashboard
  end

  def boardin
    @user = User.find(params[:id])
    @user.coins = 10000
    @user.save

    # Initiate the 15 basic parts to be sold to the user
    `rails db:seed:boardin-basic-parts`
    # Pick the 15 last generated parts to be the user basic parts
    @basicparts = Part.all[-15 .. -1]


  end
end


