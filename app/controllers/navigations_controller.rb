
class NavigationsController < ApplicationController

  before_action :set_navigation, only: :show

  def show
    @markers =
      [ {
        lat: @navigation.starting_longitude,
        lng: @navigation.starting_latitude
        },
        {
        lat: @navigation.ending_longitude,
        lng: @navigation.ending_latitude
        }
      ]
  end

  def new
    @navigation = Navigation.new
    @markers =
      [
        lat: @navigation.starting_longitude,
        lng: @navigation.starting_latitude

      ]

  end

  def itinerary_to_nextplace
  end

  def visited
    @navigation = Navigation.find(params[:place_id])
  end

  def create
    @navigation = Navigation.new(navigation_params)
    @navigation.user = current_user
    if @navigation.save
      redirect_to navigation_path(@navigation)
    else
      render :new
    end
  end

  def navigation_decision
  end

  private

  def set_navigation
    @navigation = Navigation.find(params[:id])
  end

  def navigation_params
    params.require(:navigation).permit(:user_id, :place_id, :starting_longitude, :starting_latitude, :ending_longitude, :ending_latitude, :done, :time_deadline, :date)
  end
end
