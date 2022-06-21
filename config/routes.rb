Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top",   to: "home#top"
  get "about", to: "home#about"

  post "likes/:post_id/create",  to: "likes#create"
  post "likes/:post_id/destroy", to: "likes#destroy"

  get "guest_login", to: "guest_user_login#create"

  resources :rooms, only: %i[index new create]
  resources :comments
  resources :messages

  resources :login, only: [:new, :create], controller: :sessions  
  delete    :logout, to: "sessions#destroy"

  resources :users do
    member do # idを渡す場合
      post :likes
      get :likes
    end
    collection do # idを渡さない場合
    end
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
  end

  resources :rooms do
    resources :messages
  end

  get "not_found_404",       to: "errors#not_found_404"
  # get "not_acceptable_406",  to: "errors#not_acceptable"
  # get "unprocessable_422",   to: "errors#unprocessable"
  # get "internal_server_500", to: "errors#internal_server"
end
