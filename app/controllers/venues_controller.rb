class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_venue!

  def index
    @venues = Venue.all
  end

  def show
    @events = visible_events.where(venue_id: @venue.id).includes(:category, :organizer)
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to @venue, notice: 'Venue was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @venue.update(venue_params)
      redirect_to @venue, notice: 'Venue was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @venue.destroy
      redirect_to venues_url, notice: 'Venue was successfully deleted.'
    else
      redirect_to venues_url, alert: @venue.errors.full_messages.to_sentence
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :address, :capacity_max)
  end

  def authorize_venue!
    resource = @venue || Venue
    authorize! action_name.to_sym, resource
  end

  def visible_events
    if user_signed_in? && current_user.admin?
      Event.all
    elsif user_signed_in?
      Event.where(state: Event.states[:published]).or(Event.where(user_id: current_user.id))
    else
      Event.where(state: Event.states[:published])
    end
  end
end
