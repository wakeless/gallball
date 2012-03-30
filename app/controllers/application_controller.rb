class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :recent_games

  def recent_games
    @recent_games = Game.most_recent.limit(20)
  end
end
