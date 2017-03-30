class Tile
  attr_reader :bomb, :revealed
  def initialize(is_bomb = false)
    @bomb = is_bomb
    @revealed = false
    @flagged = false
  end

  def rig_bomb
    @bomb = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def to_s
    return "F" if @flagged
    return "B" if @bomb # TODO remove debug
    return "*" unless @revealed
  end
end
