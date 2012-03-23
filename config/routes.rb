Gallball::Application.routes.draw do
  resources :sports

  resources :games

  resources :players

  match "/leaderboard" => "leaderboard#index"
  root :to => "leaderboard#index"


end
