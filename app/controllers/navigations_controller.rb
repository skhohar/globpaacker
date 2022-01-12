class NavigationsController < ApplicationController
  before_action :set_navigation, only: :show

  def generate_marker_array(places_array, info_window_partial_name = nil)
    return places_array.map do |place|
      if info_window_partial_name
        {
          lat: place.latitude,
          lng: place.longitude,
          info_window: render_to_string(
            partial: info_window_partial_name,
            locals: { place: place }
          )
        }
      else
        {
          lat: place.latitude,
          lng: place.longitude
        }
      end
    end
  end

  def show
    @nav_markers = [
      {
        lat: @navigation.starting_latitude,
        lng: @navigation.starting_longitude
      },
      {
        lat: @navigation.ending_latitude,
        lng: @navigation.ending_longitude
      }
    ]
    # Filter for weather
    if @navigation.weather == "Rainy" || @navigation.weather == "Windy"
      @places = Place.all.geocoded.where(:exterior == false)
    else
      @places = Place.all.geocoded.where(:exterior == true)
    end

    # Places qui sont des steps
    steps_places = @navigation.steps.map(&:place)
    visited_steps_places = @navigation.steps.filter(&:visited).map(&:place)
    not_visited_steps_places = @navigation.steps.filter { |s| !s.visited }.map(&:place)
    # Places qui sont PAS des steps
    places = @places.filter { |place| !steps_places.include?(place) }

    # Generate markers
    @places_markers = generate_marker_array(places, "info_window")
    @visited_step_markers = generate_marker_array(visited_steps_places, "info_window")
    @not_visited_step_markers = generate_marker_array(not_visited_steps_places, "info_window")
    @steps_markers = generate_marker_array(steps_places, "info_window")
  end

  def new
    @navigation = Navigation.new
    @markers =
      [
        lat: @navigation.starting_longitude,
        lng: @navigation.starting_latitude

      ]
  end

  def create
    @navigation = Navigation.new(navigation_params)
    @navigation.user = current_user
    @navigation.done = false
    @navigation.date = Date.today
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
