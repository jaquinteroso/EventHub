class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :cancel]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_event!, except: [:index]

  def index
    @organizer = User.find_by(id: params[:organizer_id]) if params[:organizer_id].present?
    @events = visible_events
    @events = @events.where(user_id: @organizer.id) if @organizer
    @events = @events.includes(:category, :venue, :organizer)
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

  def authorize_event!
    resource = @event || Event
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
