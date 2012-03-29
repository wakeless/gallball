class Game < ActiveRecord::Base
  belongs_to :sport

  belongs_to :winner, :class_name => "Player"
  belongs_to :loser, :class_name => "Player"

  validates_presence_of :sport, message: "When you play nothing, there is no winner or loser"
  validates_presence_of :winner, message: "Even life has a winner"
  validates_presence_of :loser, message: "Without losers, there can be no winners"

  def self.order_played
    order('created_at asc')
  end
  
  def self.most_recent
    order('created_at desc')
  end

  def to_s
    "#{winner.name} beat #{loser.name} at #{sport.name}"
  end
  
  def self.games_played(player)
    self.for_player(player).length
  end
  
  def self.for_player(player)
    where("winner_id = :player OR loser_id = :player", {:player => player})
  end
  
  def update_player_rank
    eloWinner = Elo::Player.new(:rating => self.winner.rank_for_sport(sport), :games_played => winner.games_played)
    eloLoser = Elo::Player.new(:rating => self.loser.rank_for_sport(sport), :games_played => loser.games_played)
    
    game = eloWinner.wins_from(eloLoser)
    
    winner.update_rank(sport, eloWinner.rating)
    loser.update_rank(sport, eloLoser.rating)
  end
  
  after_save :update_player_rank
  
end
