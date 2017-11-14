require 'colorize'
require 'pry'


##CREATES A FULL DECK OF 52 CARDS
##full_deck is an instance variable. Use (your variable) = @full_deck.clone to reset deck or assign
## a full deck to another variable

def deck_maker
  @spade = "\u{2660}" #spade
  @club = "\u{2663}" #club
  @diamond = "\u{2666}"#diamond
  @heart = "\u{2665}" #heart
  @full_deck = []

  deck_maker = lambda do |x|
    i = 2
    9.times do
      @full_deck << i.to_s + "," + x
      i+=1
    end
    @full_deck << "J" + "," + x
    @full_deck << "Q" + "," + x
    @full_deck << "K" + "," + x
    @full_deck << "A" + "," + x
  end

  deck_maker.call(@spade)
  deck_maker.call(@club)
  deck_maker.call(@diamond)
  deck_maker.call(@heart)
end


##Outputs heart and diamond suits in red, spade and club suits in black to terminal
def show_cards(deck)
 deck.each do |split_card_info|
   num_sym_array = split_card_info.split(",")
   #num_sym_array[0] == card value ///// num_sym_array[1] == card suit
   if num_sym_array[1] == "\u{2666}" || num_sym_array[1] == "\u{2665}"
     print num_sym_array[0].red
     puts num_sym_array[1].red
   else
     print num_sym_array[0]
     puts num_sym_array[1]
   end
 end
end

##Pick a specificed number of cards from deck_array, output to output array
def pick_a_card(deck_array, num_cards_needed, output_array)
  num_cards_needed.times do |x|
    x = deck_array.sample
    deck_array.delete(x)
    output_array << x
  end
end
deck_maker
