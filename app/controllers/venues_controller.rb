class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @events = @venue.events.includes(:category, :organizer)
  end
end
