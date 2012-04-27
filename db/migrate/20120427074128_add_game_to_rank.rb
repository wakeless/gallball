class AddGameToRank < ActiveRecord::Migration
  def change
    add_column :ranks, :game_id, :integer
  end
end
