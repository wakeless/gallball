class Game < ActiveRecord::Base
  belongs_to :winner, :class_name => "Player"
  belongs_to :loser, :class_name => "Player"

  def default_scope
    order("games.date_added desc")
  end

  def to_s
    "#{winner.name} beat #{loser.name}"
  end
end
