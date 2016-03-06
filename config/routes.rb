Rails.application.routes.draw do
  root to: 'visitors#index'
  resources :players, only: [:new, :create]
  resources :games
end
