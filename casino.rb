require "pry"
require_relative 'player'


class Casino
	attr_accessor :player

	def initialize
		puts "Welcome to the Ruby Casino"
		@player = Player.new
		menu
	end

	def menu
		@options = ["Blackjack", "Exit"]		
		@options.each_with_index { |opt, i| puts "#{i + 1}) #{opt}" }
		choice = gets.to_i - 1
		case choice
			when 1
				puts "Come again!"
				exit
			else
				puts "Invalid choice"
				menu
		end
	end
end

Casino.new