require_relative "tile.rb"

class Board
  def initialize()
    @grid = Array.new(9) { Array.new }
    @grid.each_with_index do |col, row_idx|
      9.times { |col_idx| col << Tile.new([row_idx, col_idx], self)}
    end
    bombs = Board.get_ten_random_pos
    bombs.each do |bomb|
      x,y = bomb
      @grid[x][y].make_bomb
    end
  end

  def self.new_random_board
    grid = Array.new(9) { Array.new }
    grid.each_with_index do |col, row_idx|
      9.times { |col_idx| col << Tile.new([row_idx, col_idx], self)}
    end
    bombs = Board.get_ten_random_pos
    bombs.each do |bomb|
      x,y = bomb
      grid[x][y].make_bomb
    end
    Board.new(grid)
  end

  def self.get_ten_random_pos
    positions = []
    9.times do |x|
      9.times do |y|
        positions << [x,y]
      end
    end
    positions.shuffle!
    positions.take(10)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def display
    puts "  " + (0..8).to_a.join(" ")
    @grid.each_with_index do |row, idx|
      puts idx.to_s + " " + row.join(' ')
    end
    nil
  end

  def toggle_flag(pos)
    x, y = pos
    @grid[x][y].toggle_flag
  end

  def lost?
    @grid.any? do |row|
      row.any? do |tile|
        true if tile.revealed? and tile.is_bomb?
      end
    end
  end

  def out_of_bounds?(pos)
    x, y = pos
    return true if x < 0 || y < 0 || x >= @grid.length || y >= @grid.length
    false
  end

  def reveal(pos)
    self[pos].reveal
  end

  def reveal_all
    @grid.each do |row|
      row.each do |tile|
        tile.reveal
      end
    end
    nil
  end

  def won?
    @grid.all? do |row|
      row.all? do |tile|
        if !tile.is_bomb? && tile.revealed?
          true
        elsif tile.is_bomb? && !tile.revealed?
          true
        else
          false
        end
      end
    end
  end
end
