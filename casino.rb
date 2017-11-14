require "pry"
require "colorize"
require_relative "player"
require_relative "roulette"
require_relative "slots"
require_relative "blackjack"

class Casino

	attr_accessor :player, :wallet

	def initialize
		$wallet = 100				
		puts ""		
		puts "Welcome to the Ruby Casino!".yellow
		@player = Player.new
		menu
	end

	def menu
		puts "You have: $" + "#{$wallet}".green
		puts ""
		@options = ["BlackJack", "Slots", "Roulette", "Exit"]
		@options.each_with_index { |opt, i| puts "#{i + 1}) #{opt}" }
		choice = gets.to_i - 1
		case choice
			when 0

				GameInit.new.start_game
			when 1
				SlotMachine.new
			when 2
				Roulette.new
			when 3
				puts "Goodbye!"
				exit
			else
				puts "Invalid choice"
				menu
		end
		menu
	end
end

Casino.new
