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
    joins("left join ranks r2 on ((sport_id = r2.sport_id AND player_id = r2.player_id) AND updated_at < r2.updated_at)").where("r2.id is null")
    # select("id").group("player_id, sport_id").joins("inner join (select max(updated_at), player_id, sport_id from ranks group by player_id, sport_id) agg.player_id = ranks.player_id and agg.sport_id on ranks.sport_id")
    # select("ID").group("player_id, sport_id").where("id = (select ranks.id from ranks r2 where ranks.player_id = r2.player_id and ranks.sport_id = ranks.player_id  group by player_id, sport_id having updated_at = max(updated_at))")
  end
  
  
end
