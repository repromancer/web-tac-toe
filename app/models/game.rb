class Game < ActiveRecord::Base
  has_many :game_user_joins
  has_many :users, through: :game_user_joins
  alias_attribute :players, :users

  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'



  def player_1
    @p1 ||= players.first
  end

  def player_2
    @p2 ||= players.last
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def cells
    board.split ''
  end

  def cell_taken?(index)
    cell = cells[index]
    cell == '1' || cell == '2'
  end

  def cell_taken_by?(index)
    player_1 if cells[index] == '1'
    player_2 if cells[index] == '2'
  def

  # WIN_COMBINATIONS = [
  #   [0,1,2],
  #   [3,4,5],
  #   [6,7,8],
  #   [0,3,6],
  #   [1,4,7],
  #   [2,5,8],
  #   [0,4,8],
  #   [6,4,2]
  # ]

  # def won?
  #   WIN_COMBINATIONS.detect do |combo|
  #     board.taken?(combo[0] + 1) && board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]]
  #   end
  # end



  # def draw?
  #   board.full? && ! won?
  # end



  # def over?
  #   draw? || won?
  # end



  # def winner
  #   board.cells[won?[0]] if won?
  # end



  # def turn
  #   board.display
  #   if current_player.is_a? Players::Human
  #     puts ""
  #     puts "Where would you like to move, #{current_player.token}? (1-9)"
  #   end

  #   input = current_player.move(board)

  #   until board.valid_move?(input)
  #     puts ""
  #     if input.to_i.between?(1,9)
  #       puts "Sorry, #{current_player.token}. That spot's taken!"
  #     else
  #       puts "Sorry. Please enter a valid number (1-9)."
  #     end

  #     if current_player.is_a? Players::Human
  #     puts "Where would you like to move, #{current_player.token}? (1-9)"
  #     end

  #     input = current_player.move(board)
  #   end

  #   puts ""
  #   puts ""

  #   board.update(input, current_player)

  #   if player_1.class == Players::Computer &&
  #     player_2.class == Players::Computer

  #     sleep(0.66)
  #   end

  # end



  # def play

  #   until over?
  #     turn
  #   end

  #   if won?
  #     board.display
  #     puts ""
  #     puts "Congratulations #{winner}!"
  #     puts ""
  #     puts ""
  #   else
  #     board.display
  #     puts ""
  #     puts "Cat's Game!"
  #     puts ""
  #     puts ""
  #   end

  # end


end