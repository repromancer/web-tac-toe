class Game < ActiveRecord::Base

  has_many :game_user_joins
  has_many :users, through: :game_user_joins
  alias_attribute :players, :users

  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'

  validates :board, presence: true, format: { with: /\A[012]{9}\z/, message: "must be a 9-character string consisting of digits 0-2" }

  after_initialize :initialize_board



  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], [0,3,6],
    [1,4,7], [2,5,8], [0,4,8], [6,4,2]
  ]

  def initialize_board
    # game boards are stored as a string,
    # e.g. '001000210', where:
    # '0' = empty space
    # '1' = space occupied by player_1
    # '2' = space occupied by player_2
    self.board ||= ('0')*9
  end

  def cells
    board.chars
  end






  def player_1
    @player_1 ||= players.first
  end

  def player_2
    @player_2 ||= players.last
  end

  def vs_computer?
    player_1 == player_2
  end






  def turn_count
    # count how many 1's and 2's
    # occur in the Game.board string
    # '010220000' turn_count #=> 3
    board.count '12'
  end

  def current_player
    turn_count.even? ? player_1 : player_2
  end

  def current_player_token
    turn_count.even? ? '1' : '2'
  end

  def winning_play_token
    board[won?.first]
  end




  def cell_taken?(index)
    board[index] == '1' || board[index] == '2'
  end

  def place_token(index)
    unless !(0..8).include?(index) || cell_taken?(index)
      board[index] = current_player_token

      if complete?
        if won?
          if vs_computer?
            winning_play_token == '1' ? self.loser = player_2 : self.winner = player_2
          else
            self.winner = winning_play_token == '1' ? player_1 : player_2
            self.loser = winning_play_token == '1' ? player_2 : player_1
          end
        end
      end

      save

    end
  end






  def won?
    if winner || loser
      true
    else

      WIN_COMBINATIONS.detect do |combo|
        cell_taken?(combo[0]) &&
        cells[combo[0]] == cells[combo[1]] &&
        cells[combo[1]] == cells[combo[2]]
      end

    end
  end

  def board_full?
    turn_count == 9
  end

  def tie?
    board_full? && !won?
  end

  def complete?
    won? || tie?
  end



end