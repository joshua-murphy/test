require_relative "spin"


class Roulette

  def initialize

    @temp_wallet = 500    
    
    puts "Roulette!"
    puts "Press 1 to play"
    choice = gets.to_i
    choice == 1 ? play : exit

  end

  def play

    puts "Place your bet!"    
    @bet_options = ["Red", "Black", "Even", "Odd", "Low", "High"] #,
       #"Dozen", "Column", "Corner", "Street", "Split", "Straight Up"]
    print @bet_options
    puts ""
    puts "Type 'Help' for more info"
    bet = gets.strip.downcase
    bet == "help" ? help_menu : get_bet(bet)
    
  end

  def help_menu
    puts "here's some help"
  end

  def get_bet(bet)
    puts "How much would you like to wager? You currently have: $#{@temp_wallet}"
    initial_bet = gets.to_i
    @temp_wallet = @temp_wallet - initial_bet
    initial_bet == 0 ? get_bet : spin(bet, initial_bet)
  end

end

Roulette.new