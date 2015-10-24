Rails.application.routes.draw do
  # devise_for :users

  root 'home#index'

  resources :projects do
    member do
      post 'start'
      post 'checkin'
      post 'validate' 
    end
  end
end
