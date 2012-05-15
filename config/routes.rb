Gallball::Application.routes.draw do
  resources :sports

  resources :games

  resources :players

  match "/leaderboard/(:id)" => "leaderboard#index", :as => 'leaderboard'
  root :to => "leaderboard#index"


end
