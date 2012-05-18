class StatsController < ApplicationController
  def index
    @stats = Game.by_player_week_day
  end
end
