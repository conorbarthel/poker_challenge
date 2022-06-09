require "./lib/game.rb"
require "./lib/hand_generator.rb"

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  it "can seperate deals into hands" do
    deal = %w(AS, AH, 4H, 9C, 2D, 4S, KS, JH, QD, 5C)
    expect(@game.player_1_hand(deal)).to eq(deal[0..4])
    expect(@game.player_2_hand(deal)).to eq(deal[5..9])
  end

  it "can seperate hands into rank and suits" do
    hand = %w(AS, AH, 4H, 9C, 2D)
    expect(@game)
  end

end
