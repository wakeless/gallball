Gallball::Application.routes.draw do
  resources :games

  resources :players
  root :to => "leaderboard#index"


end
