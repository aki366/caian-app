Rails.application.routes.draw do
  root 'home#top' 
  get "top" => "home#top"
  get "about" => "home#about"
  get 'posts/index' => "posts#index"
  get "posts/:id" => "posts#show"
end