class AddRanksToUsers < ActiveRecord::Migration
  def change
    Game.order_played.each do |game|
      game.update_player_rank
    end
  end
end
