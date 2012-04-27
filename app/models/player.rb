class Player < ActiveRecord::Base
  has_many :wins, class_name:  "Game", foreign_key: :winner_id
  has_many :losses, class_name: "Game", foreign_key: :loser_id
  has_many :ranks, :order => 'updated_at desc'
  has_many :games, :finder_sql => Proc.new { "SELECT * FROM games WHERE winner_id = #{id} or loser_id = #{id} ORDER BY created_at desc" }

  validates_presence_of :name, message: "People have names, yo"

  def rank_for_sport(sport)
    if self.ranks.for_sport(sport).first
      self.ranks.for_sport(sport).first.value
    elsif
      nil
    end
  end

  def streak
    streak_type = "-"
    streak = 0

    games.reverse.each do |game|
      if game.winner == self && streak_type == "-"
        streak_type = "+"
        streak = 1
      elsif game.loser == self && streak_type == "+"
        streak_type = "-"
        streak = 1
      else
        streak += 1
      end
    end

    streak_type + streak.to_s
  end

  def update_rank(sport, rank)
    rank = self.ranks.build(:sport => sport, :value => rank)
    rank.save
  end

  def percentage
    (wins.length.to_f / games.length * 100).round(2)
  end

  def games_against(player)
    wins_against(player) + losses_against(player)
  end

  def wins_against(player)
    wins.where(:loser_id => player.id)
  end

  def losses_against(player)
    losses.where(:winner_id => player.id)
  end

  def percentage_against(player)
    (wins_against(player).length.to_f / games_against(player).length * 100).round(2) if games_against(player).length > 0
  end

  def self.leaderboard(sport)
    joins(:ranks).merge(Rank.for_sport(sport).current_ranks).order("ranks.value desc").select("players.*, ranks.value")
  end
  
  def games_played
    games.length
  end

  def wins_hash
    Hash[wins.group_by(&:loser_id).collect{|g| [g[0], g[1].length]}]
  end

  def bunny
    if wins.length > 0 and wins_hash.values.max > (wins.length / 3) and wins_hash.values.max > 10
      Player.find_by_id(wins_hash.key wins_hash.values.max)
    end
  end
end
