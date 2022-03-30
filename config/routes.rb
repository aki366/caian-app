Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top", to: "home#top"
  get "about", to: "home#about"

  resources :posts
  resources :users, except: [:destroy]
  resources :likes
  post "likes/:post_id/create", to: "likes#create"
  post "likes/:post_id/destroy", to: "likes#destroy"

  get "signup", to: "users#new"
  get "login", to: "users#login_form"
  post "login", to: "users#login"
  delete "logout", to: "users#logout"

  # ゲストログイン用のルーティングを追加
  get "guest_login", to: "guest_user_login#create"

end
