class PlacesController < ApplicationController

 def show
  @user = current_user
  @navigation = Navigation.find(params[:step][:navigation_id])
  @place = Place.find(params[:id])
  @place.navigation = @place
 end

end
