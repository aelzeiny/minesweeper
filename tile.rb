class Tile
  attr_reader :bomb
  attr_accessor :adjacent_bombs, :pos, :revealed

  def initialize(is_bomb = false)
    @bomb = is_bomb
    @revealed = false
    @flagged = false
    @adjacent_bombs = nil
    @pos = nil
  end

  def rig_bomb
    @bomb = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
  end

  def reset
    @flagged = false
    @revealed = false
    @bomb = false
    @adjacent_bombs = nil
  end

  def to_s
    return "F" if @flagged
    return "B" if @bomb # TODO remove debug
    return "_" if @adjacent_bombs == 0 && @revealed
    @revealed ? @adjacent_bombs.to_s : "*"
  end
end
