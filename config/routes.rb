Rails.application.routes.draw do
  # devise_for :users

  root 'home#index'

  resources :projects do
    member do
      post 'start'
      get 'checkin'
      post 'validate' 
    end
  end
end
