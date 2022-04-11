Rails.application.routes.draw do
  resources :hardcovers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/categories', to: 'hardcovers#categories'

  # Defines the root path route ("/")
  # root "articles#index"
end
