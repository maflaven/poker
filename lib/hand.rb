class Hand

  HAND_VALUE = {
    one_pair: 1,
    two_pair: 2,
    three_kind: 3,
    straight: 4,
    flush: 5,
    full_house: 6,
    four_of_a_kind:

  }

  def initialize(cards = [])
    @cards = cards
  end

  def type
end
