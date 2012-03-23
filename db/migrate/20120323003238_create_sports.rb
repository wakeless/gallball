class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name

      t.timestamps
    end

    add_column :games, :sport_id, :integer

    Sport.reset_column_information

    s = Sport.new

    s.name = "9ball"
    s.save

    Game.all.each do |g|
      g.update_attributes!(sport_id: s.id)
    end
  end
end
