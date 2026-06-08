Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  namespace :admin do
    root "dashboard#index"
    resources :users, only: [:index, :edit, :update, :destroy]
  end

  resources :categories
  resources :venues
  resources :events do

    member do
      patch :publish
      patch :cancel
    end

    resources :registrations, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
end
