class Game < ActiveRecord::Base
  belongs_to :sport

  belongs_to :winner, :class_name => "Player"
  belongs_to :loser, :class_name => "Player"

  validates_presence_of :sport, message: "When you play nothing, there is no winner or loser"
  validates_presence_of :winner, message: "Even life has a winner"
  validates_presence_of :loser, message: "Without losers, there can be no winners"

  def default_scope
    order("games.date_added desc")
  end

  def to_s
    "#{winner.name} beat #{loser.name} at #{sport.name}"
  end
  
  
end
