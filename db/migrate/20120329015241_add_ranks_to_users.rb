class AddRanksToUsers < ActiveRecord::Migration
  def change
    Rank.delete_all
    Game.order_played.each do |game|
      game.update_player_rank
    end
  end
end
