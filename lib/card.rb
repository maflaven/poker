class Card
  attr_reader :face, :suit

  VALUE_HASH = {
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13,
    ace: 14
  }

  SUIT_HASH = {
    diamonds: 1,
    clubs: 2,
    hearts: 3,
    spades: 4
  }

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def value_face
    VALUE_HASH[face]
  end

  def self.all_faces
    VALUE_HASH.keys
  end

  def self.all_suits
    SUIT_HASH.keys
  end

  def value_suit(suit)
    SUIT_HASH[suit]
  end

  def render
    [face, suit]
  end
end
