require_relative "tile.rb"

class Board
  def initialize(grid)
    @grid = grid
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

  def display
    puts "  " + (0..8).to_a.join(" ")
    @grid.each_with_index do |row, idx|
      puts idx.to_s + " " + row.join(' ')
    end
    nil
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
end
