class StepsController < ApplicationController

  def create
    @navigation = Navigation.find(params[:navigation_id])
    @place = Place.find(params[:place_id])
    @step = Step.new
    @step.navigation = @navigation
    @step.place = @place
    @step.status = "proposed"
    if @step.save
      redirect_to navigation_path(@navigation)
      flash[:notice] = "Let's go!"
    else
      flash[:notice] = "Sorry, we can't bring you to that place"
    end
  end

  def update
  end

end
