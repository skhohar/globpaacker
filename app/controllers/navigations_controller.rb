class NavigationsController < ApplicationController
  before_action :set_navigation, only: %i[show add_place_to_itinerary]

  def show
    @nav_markers =
      [{
        lat: @navigation.starting_latitude,
        lng: @navigation.starting_longitude
      },
       {
         lat: @navigation.ending_latitude,
         lng: @navigation.ending_longitude
       }]
       if @navigation.weather == "Rainy" || @navigation.weather == "Windy"
         @places = Place.where(:exterior == false)
     else
         @places = Place.where(:exterior == true)
     end
    @places_markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        info_window: render_to_string(partial: "info_window", locals: { place: place })
      }
    end
    @steps = @navigation.steps
    console
    @step_markers = @steps.map do |step|
      {
        lat: step.latitude,
        lng: step.longitude,
      }
    end
  end

  def new
    @navigation = Navigation.new
    @markers =
      [
        lat: @navigation.starting_longitude,
        lng: @navigation.starting_latitude

      ]
  end

  def visited
    @navigation = Navigation.find(params[:place_id])
  end

  def create
    @navigation = Navigation.new(navigation_params)
    @navigation.user = current_user
    @navigation.done = false
    @navigation.date = Date.today
    # create latitude & longitude --> not working
    @nav_coords = Geocoder.search(@navigation.ending_address.to_s).first.coordinates
    @navigation.ending_longitude = @nav_coords[1]
    @navigation.ending_latitude = @nav_coords[0]
    if @navigation.save
      redirect_to navigation_path(@navigation)
    else
      flash[:notice] = 'Something is missing'
      render :new
    end
  end

  private

  def set_navigation
    @navigation = Navigation.find(params[:id])
  end

  def navigation_params
    params.require(:navigation).permit(:user_id, :place_id, :starting_longitude, :starting_latitude, :ending_longitude,
                                       :ending_latitude, :done, :time_deadline, :date, :ending_address)
  end
end
