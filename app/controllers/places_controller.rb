class PlacesController < ApplicationController

 def new
   @place = Place.new
 end

 def create
  @place = Place.new(place_params)
  @place.user_id = current_user
  @place.save
  if @place.save!
    redirect_to dashboard_path notice: "You successfully create a new place"
  else
    render :new
  end
 end

 private

  def place_params
    params.require(:place).permit(:name, :photo, :address, :duration, :description, :exterior, :interest, :senses, :environment, :rating)
  end
end
