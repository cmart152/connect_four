
require_relative 'board'
require 'pry-byebug'

class Game < Board
  attr_accessor :board

  def initialize(user_1, user_2)
    @user_1 = user_1
    @user_2 = user_2
    @board = Board.new
    @turn = true
  end

  def begin_game
    system "clear"
    puts "     welcome to connect 4, the aim is to make a row of 4 of the same coloured discs
     inserting them from the top, enter a number to choose which column to drop your disc from
     

     #{@user_1.name} is first, enter a number between 1 and 7 corresponding to the columns of the cage"

    board.output

    user_1_turn
  end

  def user_1_turn
    puts "\n\n#{@user_1.name} it's your turn"
    selection = check_input(gets.chomp)

    if @board.check_for_space(selection)
      @board.insert_piece(selection, @user_1.piece)
    else
      puts "Theres no space here, try again"
      user_1_turn
    end

    system("clear")
    @board.output

    board.check_for_win(@user_1.piece) ? game_over(@user_1) : user_2_turn
  end
  
  def user_2_turn
    puts "\n\n#{@user_2.name} it's your turn"
    selection = check_input(gets.chomp)

    if @board.check_for_space(selection)
      @board.insert_piece(selection, @user_2.piece)
    else
      puts "Theres no space here, try again"
      user_2_turn
    end

    system("clear")
    @board.output
    game_over('full') if board.check_for_full
    board.check_for_win(@user_2.piece) ? game_over(@user_2) : user_1_turn
  end

  def game_over(result)
    if result == 'full'
      puts "There is no more spaces, nobody wins this round
      Do you want to play again? y/n"
      input = check_play_again(gets.chomp)
      play_again?(input)
    else
      result.score += 1
      puts "#{result.name} is the winner!

      The current scores are -
      #{@user_1.name}: #{@user_1.score}
      #{@user_2.name}: #{@user_2.score}
      
      Do you want to play again? y/n"
      input = check_play_again(gets.chomp)
      play_again(input)
    end
  end

  def play_again(input)
    if input == 'y'
      system "clear"
      board.cage = create_empty_cage
      board.output
      @turn ? @turn = false : @turn = true
      @turn ? user_1_turn : user_2_turn
    else
      system "clear"
      puts "Good game, the final scores are

      #{@user_1.name}: #{@user_1.score}
      #{@user_2.name}: #{@user_2.score}"
    end
  end

  def check_input(input)
    input = input.to_i
    if input > 0 && input < 8
      input
    else
      puts 'Enter a number between 1-7 that corresponds to a column in the cage'
      check_input(gets.chomp)
    end
  end

  def check_play_again(input)
    input = input.downcase
    if input == 'y' || input == 'n' 
      input
    else
      puts "Enter 'y' to play again or 'n' to end game"
      check_play_again(gets.chomp)
    end
  end
end