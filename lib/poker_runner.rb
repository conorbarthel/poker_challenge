require "./lib/game.rb"
require "./lib/hand_generator.rb"

def start
  hands = HandGenerator.new("poker.txt").hands
  game = Game.new
  game.win_count(hands)
end
p start
