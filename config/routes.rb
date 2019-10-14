Rails.application.routes.draw do
  resources :authors, only: %i[index show]
end
