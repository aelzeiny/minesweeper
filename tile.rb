class Tile
  attr_reader :bomb, :revealed
  attr_accessor :adjacent_bombs

  def initialize(is_bomb = false)
    @bomb = is_bomb
    @revealed = false
    @flagged = false
    @adjacent_bombs = nil
  end

  def rig_bomb
    @bomb = true
  end

  def toggle_flag
    @flagged = !@flagged
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
    return "*" unless @revealed
  end
end
