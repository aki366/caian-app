Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top" => "home#top"
  get "about" => "home#about"

  # get "posts/index" => "posts#index"
  # get "posts/new" => "posts#new"
  # get "posts/:id" => "posts#show"
  # get "posts/:id/edit" => "posts#edit"
  # post "posts/create" => "posts#create"
  # post "posts/:id/update" => "posts#update"
  # post "posts/:id/destroy" => "posts#destroy"
  #TODO: 上記の7つのメソッドは下記にまとめられる
  resources :posts
  
  #get 'users/index'
  #post "users/create" => "users#create"
  #get "users/index" => "users#index"
  #get "users/:id" => "users#show"
  #get "users/:id/edit" => "users#edit" 
  #post "users/:id/update" => "users#update"
  #TODO: 上記のメソッドは下記にまとめられる（7つのメソッドのうち、destroy以外)
  resources :users, except: [:destroy]

  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login" => "users#login"
  delete "logout" => "users#logout"

  #TODO: ゲストログイン用のルーティングを追加
  get "guest_login" => "guest_user_login#create"

end
