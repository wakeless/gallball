class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :recent_games
  before_filter :new_game

  def recent_games
    @recent_games = Game.most_recent.limit(20)
  end

  def new_game
    @game = Game.new
  end
end
