class LeaderboardController < ApplicationController
  def index
    @leaders = Player.leaderboard
  end
end
