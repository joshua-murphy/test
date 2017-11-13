require "pry"
require_relative 'player'

class Casino
	attr_accessor :player

	def initialize
		puts "Welcome to the Ruby Casino"
		puts "What is your name, player?"
		name = gets.strip
		@player = Player.new
	end
end

Casino.new