Rails.application.routes.draw do
  get 'info/about'
  get 'info/news'

  devise_for :users
  get 'user/view_profile'
  get 'user/get_email'
  
  resources :exercise_type, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :workout, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :exercise, only: [:new, :create, :edit, :update, :destroy]
  resources :post, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "user#view_profile"
end 
