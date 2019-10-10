require "colorize"
class Tile
  def initialize(pos, board)
    @pos = pos
    @board = board
    @revealed = false
    @is_bomb = false
    @flagged = false
    @cheating = true
  end

  def to_s
    # @pos.to_s
    if !@revealed
      if @is_bomb && @cheating
        "*".colorize(:red)
      else
        "*"
      end
    elsif @flagged
      "f"
    end
  end

  def flag
    @flagged = true
  end

  def make_bomb
    @is_bomb = true
  end

  def neighbors
    #return array of neighbor tiles
  end

  def neighbor_bomb_count
    #return count of bombs in neighbors
  end

  def reveal
    # if no neighbors with bomb run reveal on them
    @revealed = true
  end
end
