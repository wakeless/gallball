class LeaderboardController < ApplicationController
  def index
    @sport = params[:id] ? Sport.find(params[:id]) : @sport = Sport.all.first

    @leaders = Player.leaderboard(@sport)
  end
end
