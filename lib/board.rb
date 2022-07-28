require 'pry-byebug'

class Board
  attr_accessor :cage
  def initialize
    @cage = create_empty_cage
  end

  def create_empty_cage
    arr = Array.new(6) { Array.new(7, "\u25ef ") }
  end

  def output
    puts " \n\n\n\n  #{@cage[0]}\n  #{@cage[1]}\n  #{@cage[2]}\n  #{@cage[3]}\n  #{@cage[4]}\n  #{@cage[5]}
    1      2     3     4     5     6     7"
  end

  def check_for_space(column)
    num = 5

    until num == -1 || @cage[num][column -1 ] == "\u25ef "
      num -= 1
    end

    num == -1 ? false : true
  end

  def check_for_full
    @cage.each do |item|
      item.each { |item| return false if item == "\u25ef " }
    end
    true
  end

  def insert_piece(column, piece)
    row = 5
    until row == -1
      if @cage[row][column - 1] == "\u25ef "
        @cage[row][column - 1] = piece 
        return
      end
      row -= 1
    end
  end

  def check_for_win(player)
    if check_for_win_horizontal(player) == true || check_for_win_vertical(player) == true || check_for_win_diagonal_left(player) == true || check_for_win_diagonal_right(player) == true
      true
    else
      false
    end 
  end

  def check_for_win_vertical(player)
    column = 0
    row = 0
    counter = 0

    until column == 7
      until row == 5
        if @cage[row][column] == @cage[row + 1][column] && @cage[row][column] == player
          counter += 1
          row += 1
          return true if counter == 3
        else
          counter = 0
          row += 1
        end
      end
      column += 1
      counter = 0
      row = 0
    end
  end

  def check_for_win_horizontal(player)
    column = 0
    row = 0
    counter = 0

    until row == 6
      until column == 6
        if @cage[row][column] == @cage[row][column + 1] && @cage[row][column] == player
          counter += 1
          column += 1
          return true if counter == 3
        else
          column += 1
          counter = 0
        end
      end

      column = 0
      counter = 0
      row += 1
    end
  end

  def check_for_win_diagonal_right(player)
    row = 0
    row_2 = 0
    column = 0
    counter = 0

    
      until row_2 == 3
        until row == 5
          if @cage[row][column] == @cage[row + 1][column + 1] && @cage[row][column] == player
            counter += 1
            row += 1
            column += 1
            return true if counter == 3
          else
            row += 1
            column += 1
            counter = 0
          end
        end
        row_2 += 1
        row = row_2
        counter = 0
        column = 0
      end

      row = 0
      column = 1
      column_2 = 1

      until column_2 == 4
        until column == 6
          if @cage[row][column] == @cage[row + 1][column + 1] && @cage[row][column] == player
            counter += 1
            row += 1
            column += 1
            return true if counter == 3
          else
            row += 1
            column += 1
            counter = 0
          end
        end
        column_2 += 1
        column = row_2
        row = 0
        counter = 0
      end
  end

  def check_for_win_diagonal_left(player)
    row = 0
    row_2 = 0
    column = 6
    counter = 0
      until row_2 == 3
        until row == 5
          if @cage[row][column] == @cage[row + 1][column - 1] && @cage[row][column] == player
            counter += 1
            row += 1
            column -= 1
            return true if counter == 3
          else
            row += 1
            column -= 1
            counter = 0
          end
        end
        row_2 += 1
        row = row_2
        counter = 0
        column = 6
      end

      row = 0
      column = 5
      column_2 = 5

      until column_2 == 2
        until column == 0
          if @cage[row][column] == @cage[row + 1][column - 1] && @cage[row][column] == player
            counter += 1
            row += 1
            column -= 1
            return true if counter == 3
          else
            row += 1
            column -= 1
            counter = 0
          end
        end
        column_2 -= 1
        column = column_2
        row = 0
        counter = 0
      end
  end
end