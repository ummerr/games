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
    diagonal_win?
    horizontal_win?
    vertical_win?
  end

  def vertical_win?
    if board[0] && board[1] && board[2] == 'X' || board[0] && board[1] && board[2] ==  'O'
      return true
    elsif board[3] && board[4] && board[5] == 'X' || board[3] && board[4] && board[5] == 'O'
      return true
    elsif board[6] && board[7] && board[8] == 'X' || board[6] && board[7] && board[8] == 'O'
      return true
    else
      false
    end
  end

  def horizontal_win?
    if board[0] && board[3] && board[6] == 'X' || board[0] && board[3] && board[6] == 'O'
      return true
    elsif board[1] && board[4] && board[7] == 'X' || board[1] && board[4] && board[7] == 'O'
      return true
    elsif board[2] && board[5] && board[8] == 'X' || board[2] && board[5] && board[8] == 'O'
      return true
    else
      false
    end
  end

  def diagonal_win?
    if board[0] && board[4] && board[8] == 'X' || board[0] && board[4] && board[8] == 'O'
      return true
    elsif board[2] && board[4] && board[6] == 'X' || board[2] && board[4] && board[6] == 'O'
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

game = Game.new


class Controller

  attr_accessor :view, :game

  def initialize
    @view = View.new
    @game = Game.new
    play
  end

  def play
    until @game.game_won?
      @game.turn_chooser
      move = @view.choose_square.to_i
      @game.valid_number(move)
      @game.print_board
    end
    @view.game_over
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

  def choose_square
    puts "Please choose a square between 1 and 9."
    gets.chomp
  end

  def game_over
    puts "The game has been won!"
  end

end

game = Controller.new
