require_relative 'card_deck'
require_relative 'blackjack_classes'

class GameInit
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @wallet = Wallet.new(1000)
    @bet = 0
    @show_bet = lambda { |bet| puts "Your current bet is #{bet}"}
    @score_lamb = lambda do |name, x|
      case x[0]
        when "2", "3", "4", "5", "6", "7", "8", "9", "10"
          name.score += x[0].to_i
        when "J", "Q", "K"
          name.score += 10
        when "A"
          @ace_lamb.call(name)
      end
    end
    @ace_lamb = lambda do |name|
      puts "Choose your value for Ace. 1 or 11?"
      ace_input = gets.strip
      if ace_input == "11"
        name.score += 11
        # @player_check_score.call
      else ace_input == "1"
        name.score += 1
        # @player_check_score.call
      end
    end
    @replay = lambda do
      puts "Another hand? Type Y or N"
      replay_input = gets.strip.upcase
      if replay_input == "Y"
        GameInit.new.start_game
      else
        exit # will be changed to 'back to casino'
      end
    end

  end # end of init methods

  def player_hand_count
      if @player.hand.length == 2
        @player.hand.each do |split_card|
          num_sym_array = split_card.split(",")
          @score_lamb.call(@player, num_sym_array)
          player_score_check
        end
      else
        num_sym_array = @player.hand[-1].split(",")
        @score_lamb.call(@player, num_sym_array)
        player_score_check
      end
    end

    def dealer_hand_count
      @dealer.hand << @dealer.hide_card
      if @dealer.hand.length == 2
        @dealer.hand.each do |split_card|
          num_sym_array = split_card.split(",")
          @score_lamb.call(@dealer, num_sym_array)
        end
      end
      dealer_score_check
    end

    def final_score_check
      dealer_hand_count
      if @player.score == 21 && @player.score != @dealer.score
        puts "BlackJack!!! Player Wins!"
        @wallet.bankroll += (@bet * 2.5)
        @wallet.show_bankroll
        @replay.call
      elsif @player.score == @dealer.score
        puts "Push. Money is Returned"
        @wallet.bankroll += @bet
        @wallet.show_bankroll
      elsif 21 - @player.score < 21 - @dealer.score
        puts "Player Wins"
        @wallet.bankroll += (@bet * 1.5)
        @wallet.show_bankroll
        @replay.call
      else
        puts "Dealer Wins"
        @wallet.show_bankroll
        @replay.call
      end
    end

    def player_score_check
      if @player.score == 21
        @player.show_score
        final_score_check
      elsif @player.score > 21
        @player.show_score
        puts "Player Busts"
        @wallet.show_bankroll
        @replay.call
      end
    end

    def dealer_score_check
      if @dealer.score > 21
        @dealer.show_score
        puts "Dealer Busts"
        @wallet.bankroll += (@bet * 1.5)
        @wallet.show_bankroll
        @replay.call
      end
    end




  def start_game
    #opening text
    puts "\n--Let's Play Some BlackJack!!!--"
    puts "----------"
    @wallet.show_bankroll
    puts "Place your initial bet"
    puts "----------"

    @bet = gets.strip.to_f
    @wallet.bankroll -= @bet
    @wallet.show_bankroll

    puts "\n"
    @show_bet.call(@bet)
    puts "----------"

    puts "Your hand"
    pick_a_card(@deck.deck, 2, @player.hand)
    show_cards(@player.hand)
    player_hand_count
    @player.show_score

    puts "\nDealer's hand"
    pick_a_card(@deck.deck, 2, @dealer.hand)
    @dealer.hide_card = @dealer.hand.delete_at(1)
    show_cards(@dealer.hand)
    puts @dealer.hide_icon
    first_round
  end

  def first_round
    puts "\nWhat would you like to do?"
    puts "1. Surrender"
    puts "2. Hit"
    puts "3. Stay"
    first_round_input = gets.strip
    case first_round_input
      when "1"
        @wallet.bankroll += (@bet / 2)
        puts "You Were Returned #{((@bet / 2).to_s)}"
        @wallet.show_bankroll
        @replay.call
      when "2"
        #pick new card/show cards/check for win/update score/show score
        puts "Your hand"
        pick_a_card(@deck.deck, 1, @player.hand)
        show_cards(@player.hand)
        player_hand_count
        player_score_check
        @player.show_score
        #show card + hide icon
        puts "\nDealer's Hand"
        show_cards(@dealer.hand)
        puts @dealer.hide_icon
        puts "\n"
        #start next round
        next_round
      when "3"
        puts "Dealer plays it out"
        dealer_hand_count
        show_cards(@dealer.hand)
        @dealer.show_score
        final_score_check
        @replay.call
      end
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
          pick_a_card(@deck.deck, 1, @player.hand)
          show_cards(@player.hand)
          player_score_check
          player_hand_count
          @player.show_score

          #show card + icon/ next round
          puts "\nDealer's Hand"
          show_cards(@dealer.hand)
          puts @dealer.hide_icon
          puts "\n"
          next_round

        when "2"
          puts "Dealer plays it out"
          dealer_hand_count
          show_cards(@dealer.hand)
          @dealer.show_score
          final_score_check
      end
    end
end

GameInit.new.start_game
