class Tile
  attr_reader :bomb
  attr_accessor :adjacent_bombs, :pos, :revealed

  def initialize(is_bomb = false)
    @bomb = is_bomb
    @revealed = false
    @flagged = false
    @adjacent_bombs = nil
    @pos = nil
    @lose = false
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

  def lose
    @lose = true
  end

  def reset
    @flagged = false
    @revealed = false
    @bomb = false
    @adjacent_bombs = nil
    @lose = false
  end

  def to_s
    return "B" if @bomb && @lose # TODO remove debug
    if @revealed
      @adjacent_bombs == 0 ? "_" : @adjacent_bombs.to_s
    elsif @flagged
      "F"
    else
      "*"
    end
  end
end
