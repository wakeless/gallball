class Rank < ActiveRecord::Base
  belongs_to :player
  belongs_to :sport

  validates_presence_of :player
  validates_presence_of :sport

  validates_presence_of :value
  
  default_scope self.order("updated_at desc")
  
  def self.for_sport(sport)
    where("sport_id = ?", sport)
  end
  
  def self.current_ranks
    select("max(id) as id, player_id, sport_id").from("ranks").group("player_id, sport_id")
    #joins("inner join (select max(id), player_id, sport_id from ranks group by player_d, sport_id) r2 on r2.sport_id = ranks.sport_id and r2.player_id = ranks.player_id");
  end

end
