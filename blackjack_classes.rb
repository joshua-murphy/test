require_relative 'card_deck'

class Player
  attr_accessor :name, :score, :hand

  def initialize(name = "Player")
    @name = name
    @hand = []
    @score = 0
  end

  def show_score
    puts "--#{self.name} score is #{self.score}--"
  end
end

class Dealer < Player
  attr_accessor :hide_icon, :hide_card

  def initialize(name = "Dealer")
    @name = name
    @hand = []
    @score = 0
    @hide_icon = "\u{1F0CF}"
    @hide_card = ""
    end
end

class Deck
  attr_accessor :deck

  def initialize
    deck_maker
    @deck = @full_deck.clone
  end

end

class Wallet
  attr_accessor :bankroll

  def initialize(amount)
    @bankroll = amount
  end

  def show_bankroll
    puts "\nYour bankroll is $#{@bankroll}"
  end
end
