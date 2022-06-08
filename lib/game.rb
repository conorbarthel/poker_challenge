require "pry"
class Game
  
  def player_1_hand(deal)
    deal[0..4]
  end

  def player_2_hand(deal)
    deal[5..9]
  end

  def rank_list(hand)
    ranks = []
    hand.select do |card|
      ranks << card[0]
    end
    convert(ranks)
  end

  def convert(ranks)
    converted = []
    ranks.each do |rank|
      if rank == "T"
        converted << 10
      elsif rank == "J"
        converted << 11
      elsif rank == "Q"
        converted << 12
      elsif rank == "K"
        converted << 13
      elsif rank == "A"
        converted << 14
      else
        converted << rank.to_i
      end
    end
    converted.sort
  end

  def suit_list(hand)
    suits = []
    hand.select do |card|
      suits << card[1]
    end
    suits
  end

  def straight(hand)
    ranks = rank_list(hand)
    index = 0
    ranks.each do |rank|
      index += 1
      return false if rank.next != ranks[index] || ranks[index] == nil
      return true
    end
  end

  def flush(hand)
    suits = suit_list(hand)
    return false if suits.all?(suits[0]) != true
  end

  def straight_flush(hand)
    flush(hand) && straight(hand)
  end

  def royal_flush(hand)
    ranks = rank_list(hand)
    return false if straight_flush(hand) != true
    ranks == [10, 11, 12, 13, 14]
  end

  def four_of_a_kind(hand)
    blank_of_a_kind(hand)[-1] == 4
  end

  def three_of_a_kind(hand)
    blank_of_a_kind(hand)[-1] == 3
  end

  def full_house(hand)
    return false if three_of_a_kind(hand) != true
    blank_of_a_kind(hand)[-2] == 2
  end

  def two_pairs(hand)
    blank_of_a_kind(hand)[-1] == 2 && blank_of_a_kind(hand)[-2] == 2
  end

  def one_pair(hand)
    blank_of_a_kind(hand)[-1] == 2
  end

  def high_card(hand)
    rank_list(hand)[-1]
  end

  def blank_of_a_kind(hand)
    ranks = rank_list(hand)
    counts = []
    ranks.each do |count_rank|
      count = 0
      ranks.each do |rank|
        count += 1 if count_rank == rank
        counts << count
      end
    end
    counts.sort
  end

  def score(hand)
    count = 0
    titles = [
              royal_flush(hand),
              straight_flush(hand),
              four_of_a_kind(hand),
              full_house(hand),
              flush(hand),
              straight(hand),
              three_of_a_kind(hand),
              two_pairs(hand),
              one_pair(hand)
            ]
    titles.each do |title|
      if title == true
        return count
      else
        count += 1
      end
    end
    count
  end

  def win_count(poker_hands)
    count = 0
    poker_hands.each do |deal|
      p1_hand = player_1_hand(deal)
      p2_hand = player_2_hand(deal)
      count += 1 if score(p1_hand) < score(p2_hand)
      if score(p1_hand) == score(p2_hand)
        count += 1 if high_card(p1_hand) > high_card(p2_hand)
      end
    end
    return count
  end

end
