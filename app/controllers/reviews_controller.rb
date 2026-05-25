class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @event, notice: 'Review submitted successfully.'
    else
      redirect_to @event, alert: @review.errors.full_messages.to_sentence
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
