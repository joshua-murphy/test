require "pry"

class Casino
    def initialize
        puts "Welcome to the Ruby Casino"
        puts "What is your name, player?"
        name = gets.strip
        #create player instance
    end
end

Casino.new