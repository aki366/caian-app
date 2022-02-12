Rails.application.routes.draw do
  get 'posts/index' => "posts#index"
  get "top" => "home#top"
  get "about" => "home#about"
end