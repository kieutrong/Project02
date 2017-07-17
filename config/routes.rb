Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"

  get "/introduce",to: "static_pages#introduce"

  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
  resources :tags, only: :show
end
