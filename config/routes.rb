Rails.application.routes.draw do
  root "pages#home"
  
  resources :events, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :venues, only: [:index, :show]
end
