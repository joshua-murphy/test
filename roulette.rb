require_relative "spin"
require "colorize"

class Roulette

  def initialize

    @temp_wallet = 500    
    
    puts "Roulette!"
    play

  end

  def play

    puts ""
    print "Place your call: "    
    @bet_options = ["Red", "Black", "Even", "Odd", "Low", "High",
       "Dozen", "Column", "Street", "Exact"]
    print @bet_options.join(", ")
    @bet_options.push("Help")
    puts ""
    puts "Type 'Help' for more info, or 'Exit' to leave game"
    bet = gets.strip.downcase

    case bet
      when "exit"
        exit
      when "help"
        help_menu
      when @bet_options.include?(bet.capitalize) == false
        puts "Invalid response"
        play
      when "dozen"
        dozen_check(bet)
      when "column"
        column_check(bet)
      when "street"
        street_check(bet)
      when "exact"
        straight_check(bet)
      else
        get_bet(bet)
    end

end  
  

  def help_menu
    puts "Welcome to the Roulette help menu!"
    puts ""
    puts "Call descriptions:"
    puts "Red/Black is a call on the color. Payout is 1:1"
    puts "Even/Odd is a call on the parity. Payout is 1:1"
    puts "Low is a call on the value (1-18). Payout is 1:1"
    puts "High is a call on the value (19-36). Payout is 1:1"
    puts "Dozen is a call on the value (1-12, 13-24, 25-36. Payout is 2:1"
    puts "Column is a call on the value (3, 6, 9, 12, 15, etc.) Payout is 2:1"
    puts "Street is a call on the value (1-3, 4-6, 7-10, etc.). Payout is 11:1"
    puts "Exact is a call on the value (1, 2, 3, 4, 5, etc. Payout is 35:1"
    puts ""
    puts "There are two chances to land on 0. This is an immediate loss. No refunds."
    puts ""
    play
  end

  def dozen_check(bet)
    puts "Which dozen?"
    puts "1) 1-12;  2) 13-24;  3) 25-36"
    @dozen_opt = gets.to_i
    case @dozen_opt
      when 1, 2, 3
        get_bet(bet)
      else
        puts "Invalid response"
        dozen_check
    end
  end  

  def column_check(bet)
    puts "Which column"
    puts "1) 1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34"
    puts "2) 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35"
    puts "3) 3, 6, 9. 12, 15, 18, 21, 24, 27, 30, 33, 36"    
    @column_opt = gets.to_i
    case @column_opt
      when 1, 2, 3
        get_bet(bet)
      else
        puts "Invalid response"
        column_check
    end
  end

  def street_check(bet)
    puts "Which set?"
    puts "1) 1, 2, 3"
    puts "2) 4, 5, 6"
    puts "3) 7, 8, 9"
    puts "4) 10, 11, 12"
    puts "5) 13, 14, 15"
    puts "6) 16, 17, 18"
    puts "7) 19, 20, 21"
    puts "8) 22, 23, 24"
    puts "9) 25, 26, 27"
    puts "10) 28, 29, 30"
    puts "11) 31, 32, 33"
    puts "12) 34, 35, 36"
    @street_opt = gets.to_i
    case @street_opt
    when 1..12
      get_bet(bet)
    else
      puts "Invalid response"
      street_check(bet)
    end
  end

  def straight_check(bet)
    puts "Which number? (1-36)"
    @straight_opt = gets.to_i
    case @straight_opt
    when 1..36
      get_bet(bet)
    else
      puts "Invalid response"
      straight_check(bet)
    end
  end

  def get_bet(bet)
    puts "How much would you like to wager? You currently have: $" + "#{@temp_wallet}".green
    initial_bet = gets.to_i.round(-1)
    puts "Wager converted to $" + "#{initial_bet}"
    if initial_bet == 0
      puts "Please choose a valid wager"
      get_bet(bet)
    end
    @temp_wallet -= initial_bet
    if @temp_wallet < 0
      @temp_wallet += initial_bet
      puts "You don't have that much!"
      get_bet(bet)
    end
    initial_bet == 0 ? get_bet : spin(bet, initial_bet)
  end

end

Roulette.new