require_relative './lib/user.rb'
require_relative './lib/game.rb' 

puts 'Welcome to connect 4'


puts "What is user 1s name?"
user_1 = User.new(gets.chomp, "\u26aa")
puts "What is user 2s name?"
user_2 = User.new(gets.chomp, "\u26ab")
game = Game.new(user_1, user_2)
game.begin_game