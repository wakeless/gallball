module ApplicationHelper
  def bunnies(player)
    player.bunnies.collect{|b| b.name}.join(', ')
  end
end
