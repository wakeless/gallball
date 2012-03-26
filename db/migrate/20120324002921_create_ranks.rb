class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.references :player
      t.references :sport
      t.integer :value

      t.timestamps
    end
    add_index :ranks, :player_id
    add_index :ranks, :sport_id
  end
end
