Rails.application.routes.draw do
  get 'habits/show'
  resources :habits, only: [:show]
end
