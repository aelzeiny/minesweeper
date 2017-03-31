require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid

  def self.default_grid
    Array.new(9) { Array.new(9) { Tile.new } }
  end

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    return nil if row >= row_size
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
    write_tile_info
  end

  def write_tile_info
    @grid.each_with_index do |row, r|
      row.each_with_index do |tile, c|
        tile.pos = [r, c]
        tile.adjacent_bombs = get_neighbors([r, c]).count(&:bomb)
      end
    end
  end

  def get_neighbors(pos)
    neighbors = []
    # byebug
    row, col = pos
    (-1..1).to_a.each do |i|
      (-1..1).to_a.each do |j|
        next if row + i < 0 || col + j < 0
        next if i == 0 && j == 0
        neighbors << self[[row + i, col + j]]
      end
    end

    neighbors.reject(&:nil?)
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

  def reveal(pos)
    me = self[pos]
    return if me.revealed
    me.reveal
    return unless me.adjacent_bombs == 0
    neighbors = get_neighbors(pos)
    neighbors.each { |neigh| reveal(neigh.pos) }
  end

  def render
    print "  #{0.upto(row_size - 1).map(&:to_s).join}\n"
    print " +#{"-" * row_size}+\n"
    @grid.each_with_index do |row, i|
      print i
      print "|"
      row.each_with_index do |tile, j|
        print tile
      end
      print "|\n"
    end
    print " +#{"-" * row_size}+\n"
  end
end
