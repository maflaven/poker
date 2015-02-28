require_relative 'card.rb'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    populate_deck
  end

  def populate_deck
    Card.all_suits.each do |suit|
      Card.all_faces.each do |face|
        self.cards << Card.new(face, suit)
      end
    end
  end

  def remove(number)
    @cards.shuffle!.pop(number)
  end
end
