require 'rspec'
require 'deck.rb'

RSpec.describe Deck do
  subject(:new_deck) { Deck.new }
  let(:spades) { new_deck.cards.select { |card| card.suit == :spades } }
  let(:hearts) { new_deck.cards.select { |card| card.suit == :hearts } }
  let(:clubs) { new_deck.cards.select { |card| card.suit == :clubs } }
  let(:diamonds) { new_deck.cards.select { |card| card.suit == :diamonds } }

  describe "#cards" do
    context "when it's a new deck" do

      it "has 52 cards" do
        expect(new_deck.cards.count).to eq(52)
      end

      it "has 13 cards in each suit" do
        expect(spades.count).to eq(13)
        expect(hearts.count).to eq(13)
        expect(clubs.count).to eq(13)
        expect(diamonds.count).to eq(13)
      end

      it "has all the cards in each suit" do
        spades_values = spades.map(&:value_face)
        hearts_values = hearts.map(&:value_face)
        clubs_values = clubs.map(&:value_face)
        diamonds_values = diamonds.map(&:value_face)

        expect(spades_values.sort).to eq((2..14).to_a)
        expect(hearts_values.sort).to eq((2..14).to_a)
        expect(clubs_values.sort).to eq((2..14).to_a)
        expect(diamonds_values.sort).to eq((2..14).to_a)
      end
    end
  end

  describe "#remove" do
    it "removes a card from the deck" do
      card_array = new_deck.remove(1)
      expect(card_array.first).to be_a(Card)
      expect(card_array).to be_an(Array)
      expect(card_array.count).to eq(1)
    end

    it "removes many cards from the deck" do
      card_array = new_deck.remove(3)
      expect(card_array.first).to be_a(Card)
      expect(card_array).to be_an(Array)
      expect(card_array.count).to eq(3)
    end

    context "when cards are removed from the deck" do
      it "the deck has that many fewer cards" do
        card_array = new_deck.remove(3)
        included = new_deck.cards.none? { |card| card_array.include?(card) }

        expect(new_deck.cards.count).to eq(49)
      end

      it "those cards are no longer in the deck" do
        card_array = new_deck.remove(3)
        included = new_deck.cards.none? { |card| card_array.include?(card) }

        expect(included).to be true
      end
    end
  end
end
