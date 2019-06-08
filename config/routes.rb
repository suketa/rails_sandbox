Rails.application.routes.draw do
  resources :fruits, only: :show
end
