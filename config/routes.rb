Rails.application.routes.draw do
  root 'users#index'
  resources :users

  get '/service-worker.js', to: 'service_worker#service_worker'
  get '/manifest.json', to: 'service_worker#manifest'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
