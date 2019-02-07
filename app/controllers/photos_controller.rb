class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end


  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    @photo.save
    redirect_to players_path
  end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end
end
