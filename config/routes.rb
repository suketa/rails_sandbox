Rails.application.routes.draw do
  resources :habits, only: [:show] do
    member do
      post :plus
      post :minus
    end
  end
end
