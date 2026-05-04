class EventsController < ApplicationController
  def index
    @events = Event.includes(:category, :venue, :organizer).all
  end

  def show
    @event = Event.find(params[:id])
  end
end
