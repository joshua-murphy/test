require 'colorize'
require 'pry'
require_relative 'card_deck_logic.rb'


$wallet = 1000.00
#remove comment tage on $wallet to make it work on its own

class BlackJack
  #creates deck
  attr_accessor :player_score, :dealer_score

  def initialize
    #create deck
    deck_maker #creates @full_deck call from relative'card_deck_logic'
    @bj_deck = @full_deck.clone
    @show_bankroll = lambda { puts "\nYour bankroll is $#{$wallet}" }
    @show_bet = lambda { |bet| puts "Your current bet is #{bet}"}
    @initial_bet

    #player hand empty array, player score set to zero, display score lambda
    @player_hand = []
    @player_score = 0
    @player_show_score = lambda { puts "--Your score is #{@player_score}--" }

    #dealer hand empty array, dealer score set to zero, hide icon,
    #dealer_hide_array
    @dealer_hand = []
    @dealer_hide_card = []
    @show_hide_icon = lambda { puts "\u{1F0CF}" }
    @dealer_score = 0
    @dealer_show_score = lambda do
      puts "--Dealer score is #{dealer_score}*--"
      puts "\n"
    end

    #player logic for selecting ace score
    @ace_lamb = lambda do
      puts "Choose your value for Ace. 1 or 11?"
      ace_input = gets.strip
      if ace_input == "11"
        @player_score += 11
        @player_check_score.call
      else ace_input == "1"
        @player_score += 1
        @player_check_score.call
      end
    end

    @dealer_ace_lamb = lambda do
      if @dealer_score <= 21
        @dealer_score += 11
      else
        @dealer_score + 1
      end
    end

    #replay game/ exit to casino lambda
    @replay = lambda do
      puts "Another hand? Type Y or N"
      replay_input = gets.strip.upcase
      if replay_input == "Y"
        BlackJack.new.start_game
      else
        exit # will be changed to 'back to casino'
      end
    end

    #check if player busts or scores blackjack
    @player_check_score = lambda do
      if @player_score == 21
        @player_show_score.call
        puts "Blackjack!"
        $wallet += (@initial_bet * 2.5)
        @show_bankroll.call
        @replay.call
      elsif @player_score > 21
        @player_show_score.call
        puts "Player Busts"
        @show_bankroll.call
        @replay.call
      end
    end

    @dealer_check_score = lambda do
      if @dealer_score == @player_score
        puts "Push"
      elsif @dealer_score <= 21 && @dealer_score > @player_score
        puts "Dealer Wins"
      elsif @dealer_score > 21
        puts "Dealer Busts"
        $wallet += @initial_bet
      elsif @player_score > @dealer_score
        puts "Player Wins"
        $wallet += @initial_bet
      end
    end
  end #end of initialize methods

  def dealer_logic
    @dealer_hand << @dealer_hide_card
    if @dealer_hand.length == 2
      @dealer_hand.each do |split_card_info|
        num_sym_array = split_card_info.split(",")
        case num_sym_array[0]
          when "2", "3", "4", "5", "6", "7", "8", "9", "10"
            @dealer_score += num_sym_array[0].to_i
          when "J", "Q", "K"
            @dealer_score += 10
          when "A"
            @dealer_ace_lamb.call
        end
      end
    end
  end

  def player_logic
      # calculate initial hand value
      if @player_hand.length == 2
        @player_hand.each do |split_card_info|
        num_sym_array = split_card_info.split(",")
          case num_sym_array[0]
            when "2", "3", "4", "5", "6", "7", "8", "9", "10"
              @player_score += num_sym_array[0].to_i
            when "J", "Q", "K"
              @player_score += 10
            when "A"
              @ace_lamb.call
          end
          @player_check_score.call
        end
      # add new card value to hand value
      else
        num_sym_array = @player_hand[-1].split(",")
        case num_sym_array[0]
          when "2", "3", "4", "5", "6", "7", "8", "9", "10"
            @player_score += num_sym_array[0].to_i
          when "J", "Q", "K"
            @player_score += 10
          when "A"
            @ace_lamb.call
        end
        @player_check_score.call
      end
    end

  def first_round
    #first round menu
    puts "What would you like to do?"
    puts "1. Surrender"
    puts "2. Hit"
    puts "3. Stay"
    first_round_input = gets.strip

    #basic first round game logic
    case first_round_input
      #surrender, return 1/2 of bet, replay.call
      when "1"
        $wallet += (@initial_bet / 2)
        puts "You Were Returned #{((@initial_bet / 2).to_s)}"
        @show_bankroll.call
        @replay.call

      when "2"
        #pick new card/show cards/check for win/update score/show score
        puts "Your hand"
        pick_a_card(@bj_deck, 1, @player_hand)
        show_cards(@player_hand)
        @player_check_score.call
        player_logic
        @player_show_score.call

        #show card + hide icon
        puts "\nDealer's Hand"
        show_cards(@dealer_hand)
        @show_hide_icon.call
        puts "\n"

        #start next round
        next_round
      when "3"
        puts "Dealer plays it out"
        dealer_logic
        show_cards(@dealer_hand)
        @dealer_show_score.call
        @dealer_check_score.call
        @replay.call
      end

    end

  def start_game
    #opening text
    puts "--Let's Play Some BlackJack!!!--"
    puts "----------"
    @show_bankroll.call
    puts "Place your initial bet"
    puts "----------"

    #takes initial bet
    @initial_bet = gets.strip.to_f
    $wallet -= @initial_bet

    puts "\n"
    @show_bet.call(@initial_bet)
    puts "----------"

    #pick player hand/show hand/add value/show score
    puts "Your hand"
    pick_a_card(@bj_deck, 2, @player_hand)
    show_cards(@player_hand)
    player_logic
    @player_show_score.call

    #pick dealer hand/first card sent to other variable/show card plus icon
    puts "\nDealer's Hand"
    pick_a_card(@bj_deck, 2, @dealer_hand)
    @dealer_hide_card = @dealer_hand.delete_at(0)
    show_cards(@dealer_hand)
    @show_hide_icon.call

    first_round
  end

  def next_round
    #next round menu
    puts "What would you like to do?"
    puts "1. Hit"
    puts "2. Stay"
    next_round_input = gets.strip

    case next_round_input
      when "1"
        #add new card/show cards/check score/add value/show score
        puts "Your hand"
        pick_a_card(@bj_deck, 1, @player_hand)
        show_cards(@player_hand)
        @player_check_score.call
        player_logic
        @player_show_score.call

        #show card + icon/ next round
        puts "\nDealer's Hand"
        show_cards(@dealer_hand)
        @show_hide_icon.call
        puts "\n"
        next_round

      when "2"
        puts "Dealer plays it out"
        dealer_logic
        show_cards(@dealer_hand)
        @dealer_show_score.call
    end
  end
end #end of class

BlackJack.new.start_game
