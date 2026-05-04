Rails.application.routes.draw do
  get "venues/index"
  get "venues/show"
  get "categories/index"
  get "categories/show"
  get "events/index"
  get "events/show"
  root "pages#home"
  
  resources :events, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :venues, only: [:index, :show]
end
