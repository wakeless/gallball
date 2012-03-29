class LeaderboardController < ApplicationController
  def index
    @sports = Sport.all() 
    @leaders = Player.leaderboard(@sports.first)
  end
end
