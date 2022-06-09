require "./lib/game.rb"
require "./lib/hand_generator.rb"

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  it "can seperate deals into hands" do
    deal = %w(AS AH 4H 9C 2D 4S KS JH QD 5C)
    expect(@game.player_1_hand(deal)).to eq(deal[0..4])
    expect(@game.player_2_hand(deal)).to eq(deal[5..9])
  end

  it "can seperate hands into rank and suits" do
    hand = %w(AS AH 4H 9C 2D)
    expect(@game.rank_list(hand)).to eq([2, 4, 9, 14, 14])
    expect(@game.suit_list(hand)).to eq(%w(S H H C D))
  end

  it "converts face cards" do
    ranks = %w(A K Q J 10)
    expect(@game.convert(ranks)).to eq([10, 11, 12, 13, 14])
  end

  it "can determine a straight" do
    hand1 = %w(2H 3S 4H 5C 6D)
    hand2 = %w(3H 4S 8C 5C 9D)
    expect(@game.straight(hand1)).to eq(true)
    expect(@game.straight(hand2)).to eq(false)
  end

  it "can determine a flush" do
    hand1 = %w(2H 3H 7H 5H JH)
    hand2 = %w(3H 4S 8C 5C 9D)
    expect(@game.flush(hand1)).to eq(true)
    expect(@game.flush(hand2)).to eq(false)
  end
end
