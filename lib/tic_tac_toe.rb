require 'pry'

class TicTacToe
    
  def initialize
    @board = Array.new(9, " ")
  end
  
  # 0 1 2 
  # 3 4 5 
  # 6 7 8 
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]]

  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts "-----------"
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move (index, character = "X")
    @board[index] = character 
  end
  
  def position_taken?(index)
    if (@board[index] == nil || @board[index] == " ")
      return false 
    else
      return true 
    end
  end 

  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  
  def turn
    puts "Please specify position between 1-9"
    input = gets.strip 
    index = input_to_index(input)
    x_o = current_player
    if valid_move?(index)
      move(index, x_o)
      display_board
    else
      turn
    end
  end
  
  def turn_count
    counter = 0 
    @board.each do |space|
      if space == "X" || space == "O"
        counter += 1 
      end
    end
    counter
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def won? 
    WIN_COMBINATIONS.detect do |combo|
      position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
    end
  end


  def full?
    @board.all? {|i| i != " "}
  end
  
  def draw?
    !won? && full?
  end
  
  def over?
    draw? || won?
  end
  
  def winner
    winning_combo = won?
    if winning_combo
      return @board[winning_combo[0]]
    end
  end

  def play
    while !over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"    
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
end

