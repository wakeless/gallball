Gallball::Application.routes.draw do
  resources :sports

  resources :games

  resources :players
  resources :stats

  match "/leaderboard/(:id)" => "leaderboard#index", :as => 'leaderboard'
  root :to => "leaderboard#index"


end
