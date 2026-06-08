class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_category!

  def index
    @categories = Category.all
  end

  def show
    @events = visible_events.where(category_id: @category.id).includes(:venue, :organizer)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_url, notice: 'Category was successfully deleted.'
    else
      redirect_to categories_url, alert: @category.errors.full_messages.to_sentence
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def authorize_category!
    resource = @category || Category
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
