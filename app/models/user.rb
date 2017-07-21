class User < ActiveRecord::Base
  has_many :game_user_joins
  has_many :games, through: :game_user_joins

  has_many :won_games, class_name: 'Game', foreign_key: 'winner_id'
  has_many :lost_games, class_name: 'Game', foreign_key: 'loser_id'

  has_many :received_invites, class_name: 'Invite', foreign_key: 'receiver_id'
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
end
