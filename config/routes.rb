Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks'}

  root to: 'events#index'

  resources :users do
    resources :availabilities
  end

  resources :availabilities, only: ['new', 'create', 'index', 'destroy']

  resources :events do
    member do
      post :attend
      delete :cancel
    end
  end
end
