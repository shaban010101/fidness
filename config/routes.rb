Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resource :profile, only: [:new, :create, :show]
  resources :trainers, only: [:index, :show]
  get '/future-sessions', action: :index, controller: 'future_sessions'
  post '/future-session', action: :create, controller: 'future_sessions'
  resources :future_sessions, only: [:destroy]
  resources :purchased_sessions, only: [:index, :show]
  post '/payment-intent', action: :intent, controller: 'payment_intents'
  devise_for :users, :controllers => {:registrations => "registrations"}
  resource :trainer_dashboard, only: [:show]
  resource :webhook, only: [:create]
  resources :availability, only: [:index, :create]
  get '/twilio/token', action: :token, controller: 'twilio'
  resources :rooms, only: [:show]
  get '/terms-and-conditions', action: :index, controller: 'terms_and_conditions'
  get '/cookie-policy', action: :index, controller: 'cookie_policy'
  get '/privacy-notice', action: :index, controller: 'privacy_notice'
  get '/disclaimer', action: :index, controller: 'disclaimer'
  get '/return_policy', action: :index, controller: 'return_policy'
end
