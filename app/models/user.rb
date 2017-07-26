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
    @slug ||= username.downcase.split.join('-')
  end

  def invites
    @invites ||= received_invites.dup + sent_invites.dup
  end

  def already_invited?(user)
    invites.detect do |invite|
      invite.sender == user || invite.receiver == user
    end
  end

  def play_loss_ratio
    won_or_tied_games = games.select do |game|
      game.winner == self || game.tie?
    end.size.to_f

    lost_games = games.select{|game| game.loser == self}.size

    if lost_games == 0
      won_or_tied_games
    else
      (won_or_tied_games / lost_games).round(1)
    end

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