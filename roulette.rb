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
       "Dozen", "Column" ] #, "Corner", "Street", "Split", "Straight Up"]
    print @bet_options.join(", ")
    @bet_options.push("Help")
    puts ""
    puts "Type 'Help' for more info, or 'Exit' to leave game"          #add help info
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
      else
        get_bet(bet)
    end

end  
  

  def help_menu
    puts "here's some help"
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

  def get_bet(bet)
    puts "How much would you like to wager? You currently have: $#{@temp_wallet}"
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