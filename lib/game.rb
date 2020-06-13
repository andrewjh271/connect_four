require_relative 'player'
require_relative 'board'
require_relative 'color'
require_relative 'escape_sequences'
require 'pry'


class Game

  attr_reader :board, :player1, :player2

  include EscapeSequences

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
      move_up(1)
      clear_line
      print "Select column for #{player.name}'s move (e.g., b): ".red
      column = gets.chomp
    end
    column
  end

  def play
    board.display
    puts
    turn = 0
    42.times do
      player = turn.even? ? player1 : player2
      move = query_move(player)
      until board.move(player, move)
        move_up(2)
        puts "Please select a column not yet full.".red
        move = query_move(player)
      end
      if board.check_for_win
        board.set_win
        reset_and_display
        puts "#{player.name} wins!"
        return
      end
      turn += 1
      reset_and_display
    end
    puts
    reset_and_display
    puts "Stalemate!"
  end

  private

  def reset_and_display
    move_up(16)
    board.display
    clear_line
    puts
    clear_line
  end
end
