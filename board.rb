require_relative 'tile.rb'

class Board
  def self.default_grid
    Array.new(9) { Array.new(9) { Tile.new } }
  end

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def row_size
    @grid.length
  end

  def col_size
    @grid[0].length
  end

  def populate
    num_bombs = 0
    until num_bombs > (row_size * col_size) / 10
      position = [rand(row_size), rand(col_size)]
      self[position].rig_bomb
      num_bombs += 1
    end
  end

  def reset
    @grid.each { |row| row.each(&:reset) }
  end

  def over?
    lose? || win?
  end

  def lose?
    @grid.any? do |row|
      row.any? { |tile| tile.bomb && tile.revealed }
    end
  end

  def win?
    @grid.all? do |row|
      row.all? { |tile| tile.bomb || tile.revealed }
    end
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile
      end
      print "\n"
    end
  end
end
