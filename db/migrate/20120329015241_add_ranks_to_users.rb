class AddRanksToUsers < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    
    Rank.delete_all
    Game.order_played.each do |game|
      say game.inspect
      game.update_player_rank
    end
  end
end
