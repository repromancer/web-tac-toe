class User < ActiveRecord::Base
  has_many :game_user_joins
  has_many :games, through: :game_user_joins

  has_many :won_games, class_name: 'Game',
    foreign_key: :winner_id, inverse_of: :winner

  has_many :lost_games, class_name: 'Game',
    foreign_key: :loser_id, inverse_of: :loser

  has_many :received_invites, class_name: 'Invite',
    foreign_key: :receiver_id, inverse_of: :receiver

  has_many :sent_invites, class_name: 'Invite',
    foreign_key: :sender_id, inverse_of: :sender

end