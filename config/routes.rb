Rails.application.routes.draw do
  # devise_for :users
  root "home#top"

  get "top",   to: "home#top"
  get "about", to: "home#about"

  get "guest_login", to: "guest_user_login#create"

  resources :login, only: [:new, :create], controller: :sessions  
  delete    :logout, to: "sessions#destroy"

  resources :users do
    member do # idを渡す場合
      post :likes
      get :likes
      post :teams
      get :teams
    end
    collection do # idを渡さない場合
    end
  end

  resources :tickets do
    resources :comments, only: %i[create destroy]
    resources :likes,    only: %i[create destroy]
  end

  resources :teams do
    resources :team_messages
    resources :tickets
    member do
      post :room
      get :room
    end
    resources :members, only: %i[create destroy]
  end

  resources :rooms, only: %i[index new create]
  resources :rooms do
    resources :messages
  end

  # matchメソッドと:viaオプションを使うことで
  # 複数のHTTP verbに同時にマッチするルーティングを作成
  match "*path", to: "application#render_404", via: :all
end
