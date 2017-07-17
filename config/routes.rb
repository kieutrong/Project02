Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"

  get "/introduce",to: "static_pages#introduce"

  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :users, only: [:index, :show]
  resources :posts, only: [:create, :destroy]
end
