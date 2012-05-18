class Game < ActiveRecord::Base
  belongs_to :sport

  belongs_to :winner, :class_name => "Player"
  belongs_to :loser, :class_name => "Player"

  has_many :ranks, :dependent => :destroy

  validates_presence_of :sport, message: "When you play nothing, there is no winner or loser"
  validates_presence_of :winner, message: "Even life has a winner"
  validates_presence_of :loser, message: "Without losers, there can be no winners"

  before_destroy :players_last_game

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
    
    winner.update_rank(sport, eloWinner.rating, self)
    loser.update_rank(sport, eloLoser.rating, self)
  end

  def players_last_game
    winner.games.first == self && loser.games.first == self
  end
  
  after_save :update_player_rank

  after_create :update_twitter

  def update_twitter
    Twitter.update(to_twitter) rescue Twitter::Error::Forbidden
  end

  def to_twitter
    "#{winner.to_twitter} beat #{loser.to_twitter} at #{sport.to_twitter}"
  end

  def self.by_player_week_day
    
    select("player_id, count(player_id) as cnt, strftime('%w', created_at)").from("(select distinct winner_id as player_id, id, created_at from games union select distinct loser_id as player_id, id, created_at from games)").group("player_id, strftime('%w', created_at)").order("strftime('%w', created_at)")
    #select("winner_id, loser_id, strftime('%w', created_at) as day, count(*) as cnt").group("winner_id, loser_id, strftime('%w', created_at)")
  end

  
end
