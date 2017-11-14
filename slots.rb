require 'pry'
require_relative 'wallet'
require 'colorize'

# slot machine
class SlotMachine
  attr_accessor :slot_1, :slot_2, :slot_3, :money

    def initialize
      slot_count = 3

      $wallet
# 3 different slots which will randomize on each spin, spitting one from each slot out
      @slot_1 = ["7".cyan, "Apple".red, "Cherry".magenta, "Watermelon".green, "Bar".blue]
      @slot_2 = ["7".cyan, "Bar".blue, "Apple".red, "Bar".blue, "Cherry".magenta]
      @slot_3= [ "7".cyan, "Banana".yellow, "7".cyan, "Apple".red, "Cherry".magenta]
      @output1 = ""
      @output2 = ""
      @output3 = ""
      first_spin
    end
# takes user through the welcome text as well as how much they would like to bet
    def first_spin
        puts "Welcome to the Slots!".magenta
        puts "You currently have $#{$wallet}".green
        puts "How much money would you like to bet today?".magenta
        puts " "
        bet_amount = gets.to_i
        puts " "
# if user tries to bet anything less than $1, it will spit them back to the welcome text
      if bet_amount < 1
        puts "Come on! You have to at least bet $1..."
        puts " "
        first_spin
      end
        modify_wallet(bet_amount)
        spin_it
    end
# user's wallet is modified once they make bet and will notify user once it is down to 0
    def modify_wallet(bet)
      $wallet -= bet
      if $wallet < 0
        $wallet += bet
        puts "Oops! Looks like you do not have enough money for that.".red
        first_spin
      end
    end
# runs every time user wants to spin
    def spin_it
      $wallet -= 25
      if $wallet < 0
        puts "Oh no! You are all out of spins.".red
        exit
      end
        puts " "
# .sample randomizes the output/slots
        @output1 = @slot_1.sample
        @output2 =  @slot_2.sample
        @output3 = @slot_3.sample
        puts @output1 + " "
        puts @output2 + " "
        puts @output3
        check_winner
        puts " "
        puts "Spin again!"
        puts "1. Spin Again".yellow
        puts "2. Exit/Cash Out".red
        puts " "
        replay = gets.strip
      if replay == "1"
        spin_it
      elsif replay == "2"
        exit
      end
    end

    def check_winner
      if @output1 == @output2 && @output2 == @output3 && @output1 == @output3
        $wallet += ( $wallet * 3 )
        puts "WINNER! You now have #{$wallet}.".green
      elsif @output1 == @output2 || @output1 == @output3 || @output2 == @output3
        $wallet += ( $wallet * 2 )
        puts "So close! You now have #{$wallet} in your winnings.".yellow
      end
    end
end

SlotMachine.new
