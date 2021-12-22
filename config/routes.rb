Rails.application.routes.draw do
  devise_for :users
  root to: "sellers#index"
  resources :items, only: [:index, :new]
end
