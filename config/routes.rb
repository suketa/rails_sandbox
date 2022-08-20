Rails.application.routes.draw do
  get 'dashboard/index'
  get 'dashboard/users'
  get 'dashboard/books'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
