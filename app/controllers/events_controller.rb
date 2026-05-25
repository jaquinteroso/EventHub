class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :cancel]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.includes(:category, :venue, :organizer).all
  end

  def show
    if user_signed_in?
      @registration = @event.registrations.find_by(user: current_user) || Registration.new
    end
    @review = Review.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user 

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def publish
    if @event.update(state: :published)
      redirect_to @event, notice: 'Event is now published and open for registration.'
    else
      redirect_to @event, alert: 'Unable to publish event.'
    end
  end

  def cancel
    if @event.update(state: :cancelled)
      redirect_to @event, notice: 'Event has been cancelled.'
    else
      redirect_to @event, alert: 'Unable to cancel event.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :max_capacity, :category_id, :venue_id)
  end
end
