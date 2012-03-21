class Player < ActiveRecord::Base
  def self.leaderboard
    select("(select count(*) from games where winner_id = players.id) / (select count(*) from games where loser_id = players.id) as percentage").select("players.*")
  end
end
