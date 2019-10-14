require "colorize"
# require "byebug"

class Tile

  def initialize(pos, board)
    @pos = pos
    @board = board
    @revealed = false
    @is_bomb = false
    @flagged = false
    @cheating = true
  end

  def inspect
    {
      "pos" => @pos,
      "revealed" => @revealed,
      "is_bomb" => @is_bomb,
      "flagged" => @flagged
    }
  end

  def to_s
    # @pos.to_s
    if @flagged
      "F"
    elsif !@revealed
      if @is_bomb && @cheating
        "*".colorize(:red)
      else
        "*"
      end
    elsif is_bomb?
      "B".colorize(:red)
    elsif neighbor_bomb_count > 0
      neighbor_bomb_count.to_s.colorize(:green)
    else
      "_"
    end
  end

  def is_bomb?
    @is_bomb
  end

  def make_bomb
    @is_bomb = true
  end

  def neighbors
    #return array of neighbor pos
    x, y = @pos
    neighbor_positions = []
    (-1..1).each do |x_mod|
      (-1..1).each do |y_mod|
        next if x_mod == 0 && y_mod == 0
        new_x = x + x_mod
        new_y = y + y_mod
        new_pos = [new_x, new_y]
        neighbor_positions << new_pos unless @board.out_of_bounds?(new_pos)
      end
    end
    neighbor_positions
  end

  def neighbor_bomb_count
    #return count of bombs in neighbors
    neighbors.count { |neighbor| @board[neighbor].is_bomb? }
  end

  def reveal
    # if no neighbors with bomb run reveal on them

    @revealed = true unless @flagged
    if neighbor_bomb_count == 0
      neighbors.each do |pos|
        neighbor = @board[pos]
        neighbor.reveal unless neighbor.revealed? || neighbor.is_bomb?
      end
    end
    nil
  end

  def revealed?
    @revealed
  end

  def toggle_flag
    @flagged = !@flagged
  end
  #private


end
