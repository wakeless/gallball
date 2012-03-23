class Sport < ActiveRecord::Base
  has_many :games

  validates_presence_of :name, message: "You want to play a sport with no name?"
end
