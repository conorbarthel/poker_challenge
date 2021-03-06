require "./lib/game.rb"
require "./lib/hand_generator.rb"
require 'pry'

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

  it "straight_flush" do
    hand1 = %w(2H 3H 7H 5H JH)
    hand2 = %w(3H 4S 8C 5C 9D)
    hand3 = %w(2H 3S 4H 5C 6D)
    hand4 = %w(6S 7S 8S 9S TS)
    expect(@game.straight_flush(hand4)).to eq(true)
    expect(@game.straight_flush(hand2)).to eq(false)
    expect(@game.straight_flush(hand1)).to eq(false)
    expect(@game.straight_flush(hand3)).to eq(false)
  end

  it "royal_flush" do
    hand1 = %w(2H 3H 7H 5H JH)
    hand2 = %w(3H 4S 8C 5C 9D)
    hand3 = %w(2H 3S 4H 5C 6D)
    hand4 = %w(6S 7S 8S 9S TS)
    hand5 = %w(TC JC QC KC AC)
    expect(@game.royal_flush(hand5)).to eq(true)
    expect(@game.royal_flush(hand2)).to eq(false)
    expect(@game.royal_flush(hand1)).to eq(false)
    expect(@game.royal_flush(hand3)).to eq(false)
    expect(@game.royal_flush(hand4)).to eq(false)
  end

  it "blank_of_a_kind" do
    hand1 = %w(2H 4H 2H 5H JH)
    hand2 = %w(3H 3S 3C 5C 9D)
    hand3 = %w(2H 2S 4H 4C 4D)
    hand4 = %w(6S 7S 8S 9S TS)

    expect(@game.blank_of_a_kind(hand1)[-1]).to eq(2)
    expect(@game.blank_of_a_kind(hand2)[-1]).to eq(3)
    expect(@game.blank_of_a_kind(hand2)[-2]).to eq(1)
    expect(@game.blank_of_a_kind(hand3)[-1]).to eq(3)
    expect(@game.blank_of_a_kind(hand3)[-2]).to eq(2)
    expect(@game.blank_of_a_kind(hand4).sample).to eq(1)
  end
end
