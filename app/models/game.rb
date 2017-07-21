class Game < ActiveRecord::Base
  has_many :game_user_joins
  has_many :users, through: :game_user_joins
  alias_attribute :players, :users

  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'
end
