Rails.application.routes.draw do
  devise_for :users

  get "users/verify", to: 'users#show_verify', as: 'verify'
  post "users/verify"
  post "users/resend"

  root to: "home#index"

  resources :messages
  resources :contacts
end
