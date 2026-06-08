class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
    @review.user = current_user
    authorize! :create, @review

    if @review.save
      redirect_to @event, notice: 'Review submitted successfully.'
    else
      redirect_to @event, alert: @review.errors.full_messages.to_sentence
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @review = @event.reviews.find(params[:id])
    authorize! :destroy, @review

    @review.destroy
    redirect_to @event, notice: "Review was successfully deleted."
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
