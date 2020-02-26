Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  mount API::Base, at: "/"
  resource :profile, only: [:new, :create, :show]
  resources :trainers, only: [:index, :show]
  resources :sessions, only: [:create, :show]
  get '/sessions/:id', to: 'sessions#show' 
  post '/payment_intent', to: 'sessions#intent'
  devise_for :users, :controllers => {:registrations => "registrations"}
  resource :trainer_dashboard, only: [:show]
end
