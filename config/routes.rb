Rails.application.routes.draw do
  # devise_for :users

  root 'home#index'

  resources :projects do
    member do
      post 'start'
      get 'start'
      post 'checkin'
      get 'checkin'
      post 'validate' 
      get 'validate'
    end
  end
end
