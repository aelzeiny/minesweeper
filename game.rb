require_relative 'board.rb'

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
  end

  def play_round

  end
end
