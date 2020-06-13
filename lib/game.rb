require_relative 'player'
require_relative 'board'
require_relative 'color'


class Game

  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(query_name(1), 1)
    @player2 = Player.new(query_name(2), 2)
  end

  def query_name(num)
    print "Enter Player #{num}'s name: "
    gets.chomp
  end

  def query_move(player)
    print "Select column for #{player.name}'s move: "
    column = gets.chomp
    until(/[abcdefg]/.match(column) &&  column.length == 1)
      print "Select column for #{player.name}'s move (e.g., b): "
      column = gets.chomp
    end
    column
  end

  def play
    turn = 0
    loop do
      player = turn.even? ? player1 : player2
      board.display
      move = query_move(player)
      until board.move(player, move)
        puts "That column is full. Please select a column that isn't."
        move = query_move(player)
      end
      if winning_direction = board.winning_direction
        board.display_win(winning_direction)
        puts "#{player.name} wins!"
        return
      elsif board.stalemate?
        puts "Stalemate!"
        return
      end
      turn += 1
      board.display
    end
  end
end
