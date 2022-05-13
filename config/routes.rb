Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top", to: "home#top"
  get "about", to: "home#about"

  resources :posts do
    resources :comments, only: %i[create destroy]
  end

  resources :rooms, only: %i[index new create]

  resources :rooms do
    resources :messages
  end

  resources :comments

  resources :messages

  resources :users do
    member do # idを渡す場合
      post :likes
      get :likes
    end
    collection do # idを渡さない場合
      get :login_form
      post :login
      delete :logout
    end
  end

  post "likes/:post_id/create", to: "likes#create"
  post "likes/:post_id/destroy", to: "likes#destroy"

  get "signup", to: "users#new"
  get "login", to: "users#login_form"
  post "login", to: "users#login"
  delete "logout", to: "users#logout"

  # ゲストログイン用のルーティングを追加
  get "guest_login", to: "guest_user_login#create"

end
