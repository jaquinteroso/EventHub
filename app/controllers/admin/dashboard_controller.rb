module Admin
  class DashboardController < BaseController
    def index
      @users_count = User.count
      @categories_count = Category.count
      @venues_count = Venue.count
      @reviews = Review.includes(:user, :event).order(created_at: :desc).limit(10)
    end
  end
end
