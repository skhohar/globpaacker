class PlacesController < ApplicationController

 def new
   @place = Place.new
 end

 def create
  @place = Place.new(place_params)
  @place.user = current_user
  if @place.save
    redirect_to dashboard_path notice: "You successfully create a new place"
  else
    flash[:notice] = 'Something is missing'
    render :new
  end
 end

 def destroy
  @place.destroy
    redirect_to dashboard_path, notice: 'The place was successfully destroyed.'
 end

 private

  def place_params
    params.require(:place).permit(:name, :photo, :address, :duration, :description, :exterior, :interest, :senses, :environment, :rating)
  end
end
