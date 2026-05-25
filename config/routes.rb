Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  resources :categories
  resources :venues
  resources :events do

    member do
      patch :publish
      patch :cancel
    end

    resources :registrations, only: [:create, :destroy]
    resources :reviews, only: [:create]
  end
end
