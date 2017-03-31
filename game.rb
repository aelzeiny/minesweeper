require_relative 'board.rb'
require 'byebug'

class MinesweeperGame
  def initialize(board = Board.new)
    @board = board
  end

  def play
    @board.reset
    @board.populate
    until @board.over?
      play_round
    end
    @board.display_all_bombs if @board.lost?
    @board.render
    puts "You #{@board.won? ? "Won!" : "Lost!"}"
  end

  def play_round
    @board.render
    puts "Enter your move in r,c format (e.g '3,4')"
    print "> "
    p input = get_input

    until valid?(input)
      puts "INVALID INPUT"
      input = get_input
    end
    if input[0].downcase == 'c'
      @board.reveal(input[1])
    else
      @board.flag(input[1])
    end
  end

  def get_input
    input = gets.chomp
    action = input[0]
    loc = input.scan(/\d+/).map(&:to_i)
    [action, loc]
  end

  def valid?(input)
    return false unless "FCfc".include?(input[0])
    loc = input[1]
    loc.length == 2 && loc[0].between?(0, @board.row_size - 1) &&
      loc[1].between?(0, @board.col_size - 1)
  end
end

if $PROGRAM_NAME == __FILE__
  g = MinesweeperGame.new
  g.play
end
