require_relative 'card.rb'

class Hand

  HAND_VALUE = {
    straight_flush: 8,
    four_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_kind: 3,
    two_pair: 2,
    one_pair: 1,
    high_card: 0
  }

  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  # currently only ties hands with same value.
  # future version should use type data for tiebreakers
  def self.compare(*hands)
    hands_type_value = {}

    hands.each do |hand|
      hands_type_value[hand] = hand.value(hand.type)
    end

    hands_by_value = hands_type_value.sort_by { |hand, value| value }

    highest_value = hands_by_value.last[1]

    winners = hands_by_value.select { |hand, value| value == highest_value }

    winners.map! { |hand| hand[0] }
  end

  def render
    render = []

    cards.each { |card| render << card.render }

    render
  end

  def type
    # if straight_flush
    #   return [:straight_flush, straight_flush]
    Hand.all_hand_types.each do |type|
      return [type, eval("#{type}")] if eval("#{type}")
    end
  end

  def value(type)
    HAND_VALUE[type.first]
  end

  private

  def self.all_hand_types
    HAND_VALUE.keys
  end

  def high_card
    card_face_values = cards.map { |card| Card.value_face(card.face) }.sort

    Card.face(card_face_values.pop)
  end

  def one_pair
    card_face_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_face_counts[card.face] += 1 }

    card_face_counts.select! { |face, count| count == 2 }

    card_face_counts.keys.first
  end

  def two_pair
    card_face_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_face_counts[card.face] += 1 }

    card_face_counts.select! { |face, count| count == 2 }

    if card_face_counts.keys.count < 2
      return nil
    end

    val = card_face_counts.keys.map! { |face| Card.value_face(face) }.sort!.pop

    return Card.face(val)
  end

  def three_kind
    card_face_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_face_counts[card.face] += 1 }

    card_face_counts.select! { |face, count| count == 3 }

    card_face_counts.keys.first
  end

  def straight
    card_face_values = cards.map { |card| Card.value_face(card.face) }

    card_face_values.sort!

    straight = true

    (0...(card_face_values.count - 1)).each do |i|
      straight = false if card_face_values[i] != (card_face_values[i + 1] - 1)
    end

    return Card.face(card_face_values.pop) if straight

    nil
  end

  def flush
    card_suit_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_suit_counts[card.suit] += 1 }

    card_suit_counts.select! { |suit, count| count == 5 }

    card_suit_counts.keys.first
  end

  def full_house
    card_face_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_face_counts[card.face] += 1 }

    card_face_counts.select! { |face, count| count >= 2 }

    if card_face_counts.count == 2
      return card_face_counts.select { |suit, count| count == 3 }.keys.first
    end

    nil
  end

  def four_kind
    card_face_counts = Hash.new { |h, k| h[k] = 0 }

    cards.each { |card| card_face_counts[card.face] += 1 }

    card_face_counts.select! { |face, count| count == 4 }

    card_face_counts.keys.first
  end

  def straight_flush
    return straight if straight && flush

    nil
  end




end
