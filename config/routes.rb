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

  # matchメソッドと:viaオプションを使うことで
  # 複数のHTTP verbに同時にマッチするルーティングを作成
  match "*path", to: "application#render_404", via: :all
end
