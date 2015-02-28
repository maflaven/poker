require 'rspec'
require 'hand.rb'

RSpec.describe Hand do
  subject(:new_hand) { Hand.new( [Card.new(:three, :clubs),
                                  Card.new(:ace, :spades),
                                  Card.new(:three, :diamonds),
                                  Card.new(:seven, :hearts),
                                  Card.new(:queen, :diamonds)
                                  ] ) }
  subject(:tying_hand) { Hand.new( [Card.new(:three, :spades),
                                  Card.new(:ace, :diamonds),
                                  Card.new(:three, :clubs),
                                  Card.new(:seven, :spades),
                                  Card.new(:queen, :hearts)
                                  ] ) }
  subject(:winning_hand) { Hand.new( [Card.new(:ace, :clubs),
                                  Card.new(:ace, :clubs),
                                  Card.new(:ace, :diamonds),
                                  Card.new(:six, :hearts),
                                  Card.new(:king, :diamonds)
                                  ] ) }
  subject(:losing_hand) { Hand.new( [Card.new(:two, :clubs),
                                  Card.new(:three, :clubs),
                                  Card.new(:four, :diamonds),
                                  Card.new(:five, :hearts),
                                  Card.new(:seven, :diamonds)
                                  ] )  }

  describe "#initialize" do
    it "creates an empty array of cards by default" do
      expect(Hand.new.cards).to be_an(Array)
      expect(Hand.new.cards).to be_empty
    end

    it "creates an array of given cards" do
      expect(new_hand).to be_an(Array)
      expect(new_hand.cards.count).to eq(5)
    end

  end

  describe "#render" do
    it "shows the cards in plain text" do
      expect(new_hand.render).to eq([[:three, :clubs], [:ace, :spades],
                                     [:three, :diamonds], [:seven, :hearts],
                                     [:queen, :diamonds]])
    end
  end

  describe "#type" do
    it "returns the correct type of hand with additional info" do
      expect(new_hand.type).to eq(:one_pair, :three)
    end
  end

  describe "::compare" do
    context "if there is one winning hand" do
      it "returns the winning hand in an array" do
        expect(Hand.compare(winning_hand, losing_hand,
                            new_hand)).to eq([winning_hand])
      end
    end

    context "if there are two winning hands" do
      it "returns both both hands in an array" do
        expect(Hand.compare(new_hand, tying_hand,
                            losing_hand)).to eq([new_hand, tying_hand])
      end
    end
  end
end
