require 'pry'

class Game
  attr_accessor :board, :turn_counter, :current_token

  def initialize
    @board = Array.new(9) { nil }
    @player_one = 'X'
    @player_two = 'O'
    @turn_counter = 9
    @current_token = nil
  end

  def valid_number(num)
    if num > 0 && num < 10
      input_to_index(num)
    else
      puts "Please enter a valid number!"
    end
  end

  def input_to_index(input)
    index = input.to_i - 1
    check_square(index)
  end

  def check_square(num)
    if @board[num] == nil
      update_square(num)
    else
      puts "That square is already taken, please pick another!"
    end
  end

  def update_square(num)
    @board[num] = @current_token
    @turn_counter -= 1
  end

  def turn_chooser
    if @turn_counter % 2 == 0
      @current_token = @player_two
    else
      @current_token = @player_one
    end
  end

  #look for shorthand on how to make this less onerous
  def game_won?
    if diagonal_win?
      true
    elsif horizontal_win?
      true
    elsif vertical_win?
      true
    else
      false
    end
  end

  def vertical_win?
    if board[0] == 'X' && board[1] == 'X' && board[2] == 'X'
      return true
    elsif board[0] == 'O' && board[1] == 'O' && board[2] ==  'O'
      return true
    elsif board[3] == 'X' && board[4] == 'X' && board[5] == 'X'
      return true
    elsif board[3] == 'O' && board[4] == 'O' && board[5] == 'O'
      return true
    elsif board[6] == 'X' && board[7] == 'X' && board[8] == 'X'
      return true
    elsif board[6] == 'O' && board[7]== 'O'  && board[8] == 'O'
      return true
    else
      false
    end
  end

  def horizontal_win?
    if board[0] == 'X' && board[3] == 'X' && board[6] == 'X'
      return true
    elsif board[0] == 'O' && board[3] == 'O' && board[6] == 'O'
      return true
    elsif board[1] == 'X' && board[4] == 'X' && board[7] == 'X'
      return true
    elsif board[1] == 'O' && board[4] == 'O' && board[7] == 'O'
      return true
    elsif board[2] == 'X' && board[5] == 'X' && board[8] == 'X'
      return true
    elsif board[2] == 'O' && board[5] == 'O' && board[8] == 'O'
      return true
    else
      false
    end
  end

  def diagonal_win?
    if board[0] == 'X' && board[4] == 'X' && board[8] == 'X'
      return true
    elsif board[0] == 'O' && board[4] == 'O' && board[8] == 'O'
      return true
    elsif board[2] == 'X' && board[4] == 'X' && board[6] == 'X'
      return true
    elsif board[2] == 'O' && board[4] == 'O' && board[6] == 'O'
      return true
    else
      false
    end
  end

  def tied?
    @board.all? {|cell| cell != nil}
  end

  def print_board
    @board.each_slice(3) {|cell| p cell}
  end

end

# game = Game.new
# game.turn_chooser
# game.update_square(0)
# game.turn_chooser
# game.update_square(4)
# game.turn_chooser
# game.update_square(8)
# game.print_board
# p game.game_won?
#game won method is broken.  it takes either x's or o's for winning condition.
#game does not process diagonal wins yet.

class Controller

  attr_accessor :view, :game

  def initialize
    @view = View.new
    @game = Game.new
    play
  end

  def play
    until @game.game_won?
      if @game.tied?
        puts "The game is tied!"
        break
      end
      @game.turn_chooser
      token = @game.current_token
      @view.player_prompt(token)
      move = @view.choose_square.to_i
      @game.valid_number(move)
      @view.current_board
      @game.print_board
      @view.legend
    end

    current_token = @game.current_token
    @view.game_over(current_token)
  end

end

class View

  def initialize
    welcome
  end

  def welcome
    puts "Welcome to Tic Tac Toe"
    puts "Please choose a number between 1 and 9"
    puts " 1 | 2 | 3 "
    puts " --------- "
    puts " 4 | 5 | 6 "
    puts " --------- "
    puts " 7 | 8 | 9 "
  end

  def current_board
    puts "---------------------------------------"
    puts "the board looks like this"
  end

  def legend
    puts "remember the keys to the board are"
    puts " 1 | 2 | 3 "
    puts " --------- "
    puts " 4 | 5 | 6 "
    puts " --------- "
    puts " 7 | 8 | 9 "
  end

  def player_prompt(token)
    puts "Player #{token} please choose an available square"
  end

  def choose_square
    gets.chomp
  end

  def game_over(token)
    puts "The game has been won by #{token}!"
    puts "Unless it was tied, then just kidding"
  end

end

game = Controller.new
