require 'rspec'
require 'card.rb'

RSpec.describe Card do
  subject (:card) { Card.new(:ace, :heart) }

  describe "#initialize" do
    it "should initialize a card with a given value and suit" do
      expect(card.value_face).to eq(14)
      expect(card.suit).to eq(:heart)
    end
  end

  describe "#render" do
    it "should display card's face (not its value) and suit" do
      expect(card.render).to eq([:ace, :heart])
    end
  end
end
