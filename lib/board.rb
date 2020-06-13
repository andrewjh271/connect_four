require_relative 'color'
require_relative 'player'
require 'pry'

class Board

  private

  attr_reader :squares, :last_move, :directions, :win_direction, :win_start

  public

  def initialize
    @squares = []
    7.times { |i| @squares[i] = [] }
    @directions = [-1, 0, 1].repeated_permutation(2).to_a.reject { |arr| arr == [0, 0] }
  end

  def display
    puts
    5.downto(0) do |i|
      7.times do |j|
        print "┆ #{squares[j][i] ? squares[j][i] : ' '} "
      end
      puts '┆'
      puts '┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈'
    end
    puts '  a   b   c   d   e   f   g'
  end

  def move(player, char)
    disc = player.first? ? '◉'.yellow : '◉'.red
    column = char.ord - 97
    return false unless column.between?(0, 6) && squares[column].length.between?(0, 5)
    @squares[column] << disc
    # @last_move = [column, squares[column].length - 1, disc]
  end

  def check_for_win
    squares.each_with_index do |column, column_index|
      column.each_with_index do |square, row_index|
        
        directions.each do |direction|
          column = column_index
          row = row_index
          3.times do |i|
            column += direction[0]
            row += direction[1]
            break unless column.between?(0, 6) && row.between?(0, 5) &&
                         squares[column][row] == square
            if i == 2
              @win_start = [column_index, row_index]
              @win_direction = direction
              return true
            end
          end
        end
      end
    end
    false
  end

  def set_win
    column = win_start[0]
    row = win_start[1]
    star = squares[column][row] == '◉'.yellow ? '★'.yellow : '★'.red
    4.times do |i|
      @squares[column][row] = star
      column += win_direction[0]
      row += win_direction[1]
    end
  end

end