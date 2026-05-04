class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @events = @category.events.includes(:venue, :organizer)
  end
end
