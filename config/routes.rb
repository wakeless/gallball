Gallball::Application.routes.draw do
  resources :games

  resources :players

  match "/leaderboard" => "leaderboard#index"
  root :to => "leaderboard#index"


end
