Rails.application.routes.draw do
  root 'users#index' 
  get 'posts/index' => "posts#index"
  get "top" => "home#top"
  get "about" => "home#about"
end