class PlacesController < ApplicationController

  def show
    @navigation = Navigation.find(params[:navigation_id])
    @place = Place.find(params[:id])
  end


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
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to dashboard_path, notice: 'The place was successfully destroyed.'
  end

    def add_place_to_itinerary(place)
    # on sélectionnne la navigation --> ok
    @navigation = Navigation.find(params[:navigation_id])
    # on récupère la route entre départ et arrivée, via ses waypoints
    @basic_route = [....waypoints....]
    # on prend la place --> ok
    @place = Place.find(params[:id])
    # on récupère ses coordonnées
    # on inscrit les coordonnées de la place comme waypoint
    @basic_route << @place
  end


  private

  def place_params
    params.require(:place).permit(:name, :photo, :address, :duration, :description, :exterior, :interest, :senses,
                                  :environment, :rating)
  end
end
