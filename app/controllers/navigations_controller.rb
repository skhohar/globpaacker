class NavigationsController < ApplicationController

  # before_action :set_navigation, only: [:show, :new]

  def show
    @navigation = Navigation.find(params[:id])
    @markers =
      {
        lat: @navigation.starting_latitude,
        lng: @navigation.starting_longitude
      }
  end

  def new
    @navigation = Navigation.new
  end

  def itinerary_to_nextplace
  end

  def visited
    @navigation = Navigation.find(params[:place_id])
  end

  def navigation_decision
  end

  private

  def set_navigation
    @navigation = Navigation.find(params[:place_id])
  end

  def navigation_params
   params.require(:navigation).permit(:user_id, :place_id, :starting_longitude, :starting_latitude, :ending_longitude, :ending_latitude, :done, :time_deadline, :date)
  end
end
