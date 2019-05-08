Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  mount API::Base, at: "/"
  resource :profile, only: [:new, :create, :show]
  resources :trainers, only: [:index, :show] do
    resources :sessions, only: [:new, :create]
  end
  get '/sessions/:id', to: 'sessions#show' 
  devise_for :users, :controllers => {:registrations => "registrations"}
  resource :trainer_dashboard, only: [:show]
end
