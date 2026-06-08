class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(user: current_user)
    authorize! :create, @registration
    
    if @registration.save
      status_msg = @registration.confirmed? ? "You are confirmed!" : "You are on the waitlist."
      redirect_to @event, notice: "Registered successfully. #{status_msg}"
    else
      redirect_to @event, alert: @registration.errors.full_messages.to_sentence
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @registration = current_user.registrations.find(params[:id])
    authorize! :destroy, @registration
    
    @registration.destroy
    redirect_to @event, notice: "Registration cancelled. Waitlist promoted automatically if applicable."
  end
end
