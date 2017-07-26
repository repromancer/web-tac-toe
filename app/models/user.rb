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


  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 32 }

  has_secure_password

  def self.find_by_slug(slug)
    all.detect { |user| user.slug == slug }
  end

  def slug
    username.downcase.split.join('-')
  end



  def play_loss_ratio
    completed_games = games.select(&:complete?).size.to_f
    lost_games = games.select{|game| game.loser == self}.size
    (completed_games / lost_games).round(1)
  end

  def opponents
    games.collect do |game|
      game.players.detect{|user| user != self}
    end.uniq.compact
  end

  def wins_against(user)
    user.games.select{|game| game.winner == self}.size
  end

  def losses_against(user)
    user.games.select{|game| game.loser == self}.size
  end

  def wins_vs_computer
    games.select{|game| game.won? && game.loser.nil?}.size
  end

  def losses_vs_computer
    games.select{|game| game.won? && game.winner.nil?}.size
  end

end