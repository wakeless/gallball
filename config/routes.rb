Gallball::Application.routes.draw do
  resources :sports

  resources :games

  resources :players

  match "/leaderboard/(:id)" => "leaderboard#index"
  root :to => "leaderboard#index"


end
