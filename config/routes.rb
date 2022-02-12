Rails.application.routes.draw do
  root 'home#top' 
  get 'posts/index' => "posts#index"
  get "top" => "home#top"
  get "about" => "home#about"
end