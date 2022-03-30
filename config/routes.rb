Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top" => "home#top"
  get "about" => "home#about"

  resources :posts
  resources :users, except: [:destroy]
  resources :likes
  post "likes/:post_id/create", to: "likes#create"
  post "likes/:post_id/destroy", to: "likes#destroy"

  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  delete "logout" => "users#logout"

  # ゲストログイン用のルーティングを追加
  get "guest_login" => "guest_user_login#create"

end
