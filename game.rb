require_relative "board.rb"

class Game
  def initialize
    @board = Board.new
  end

  def play
    until @board.won? || @board.lost?
      system("clear")
      @board.display
      coord = prompt_user_for_coordinates
      prompt_for_action(coord)
    end

    system("clear")
    if @board.won?
      puts "You Won!"
    else
      puts "You Loose!"
    end
    @board.reveal_all
    @board.display
  end

  def prompt_user_for_coordinates
    print "please enter a cordinate (x,y) > "
    gets.chomp.split(",").map(&:to_i)
  end

  def prompt_for_action(coord)
    print "[R]eveal or [F]lag? > "
    action = gets.chomp.upcase
    if action == "R"
      @board.reveal(coord)
    elsif action == "F"
      @board.toggle_flag(coord)
    end
  end

end
