class Tile
  attr_reader :bomb, :revealed
  def initialize(is_bomb = false)
    @bomb = is_bomb
    @revealed = is_bomb
  end

  def rig_bomb
    @bomb = true
  end

  def to_s
    @bomb ? "*" : "-"
  end
end
