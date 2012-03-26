class Rank < ActiveRecord::Base
  belongs_to :player
  belongs_to :sport

  validates_presence_of :player
  validates_presence_of :sport

  validates_presence_of :value
  
  def self.for_sport(sport)
    where("sport_id = ?", sport)
  end
  
end
