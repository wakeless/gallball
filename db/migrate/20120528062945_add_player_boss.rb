class AddPlayerBoss < ActiveRecord::Migration
  def change
    add_column :players, :boss_id, :integer

    Player.all.each do |p|
      p.update_boss
    end
  end
end
