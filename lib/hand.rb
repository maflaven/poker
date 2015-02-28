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
    high_hand: 0
  }

  def initialize(cards = [])
    @cards = cards
  end


  def self.compare(*hands)
  end


  private

  def type
    # if straight_flush
    #   return [:straight_flush, straight_flush]
    Hand.all_hand_types.each do |type|
      return [type, eval("#{type}")] if eval("#{type}")
    end
  end

  def hand_value(type)
    HAND_VALUE[type]
  end

  def high_hand
    sort.pop
  end

  def one_pair
    highest_pair_value = 0

    (0...(cards.length - 1)).each do |i|
      ((i + 1)...cards.length).each do |j|
        if cards[i] == cards[j] && cards[i] > highest_pair_value
          highest_pair_value = cards[i]
        end
      end
    end

    return highest_pair_value if highest_pair_value > 0

    nil
  end

  def two_pair
    pair_values = []

    (0...(cards.length - 1)).each do |i|
      ((i + 1)...cards.length).each do |j|
        highest_pair_value << cards[i] if cards[i] == cards[j]
      end
    end

    pair_values.sort!

    return pair_values.last if pair_values.count == 2

    nil
  end

  def three_kind
    pair_values = Hash.new { |h, k| h[k] = 0 }

    each { |card| pair_values[card] += 1 }

  end

  def straight

  end

  def flush

  end

  def full_house

  end

  def four_kind

  end

  def straight_flush

  end

  def self.all_hand_types
    HAND_VALUE.keys
  end




end
