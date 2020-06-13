require_relative 'color'
require_relative 'player'
require 'pry'

class Board

  private

  attr_reader :squares, :last_move, :directions

  public

  def initialize
    @squares = []
    7.times { |i| @squares[i] = [] }
    @directions = [-1, 0, 1].repeated_permutation(2).to_a.reject { |arr| arr == [0, 0] }
  end

  def display
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
    @last_move = [column, squares[column].length - 1, disc]
  end

  def winning_direction
    directions.each do |direction|
      column = last_move[0]
      row = last_move[1]
      3.times do |i|
        column += direction[0]
        row += direction[1]
        break unless column.between?(0, 6) && row.between?(0, 5) &&
                     squares[column][row] == last_move[2]
        return direction if i == 2
      end
    end
    nil
  end

  def display_win(direction)
    column = last_move[0]
    row = last_move[1]
    star = last_move[2] == '◉'.yellow ? '★'.yellow : '★'.red
    4.times do |i|
      @squares[column][row] = star
      column += direction[0]
      row += direction[1]
    end
    display
  end

  def stalemate?
    squares.all? { |col| col.length == 6 }
  end

end