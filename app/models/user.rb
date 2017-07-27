class User < ActiveRecord::Base

  has_many :games_as_player_1, class_name: 'Game',
    foreign_key: :player_1_id, inverse_of: :player_1

  has_many :games_as_player_2, class_name: 'Game',
    foreign_key: :player_2_id, inverse_of: :player_2

  has_many :won_games, class_name: 'Game',
    foreign_key: :winner_id, inverse_of: :winner

  has_many :lost_games, class_name: 'Game',
    foreign_key: :loser_id, inverse_of: :loser

  has_many :received_invites, class_name: 'Invite',
    foreign_key: :receiver_id, inverse_of: :receiver

  has_many :sent_invites, class_name: 'Invite',
    foreign_key: :sender_id, inverse_of: :sender


  validates :username, presence: true, uniqueness: { case_sensitive: false, message: 'choice is already taken. <br> (Note: Usernames are not case sensitive.)'}, length: { minimum: 4, maximum: 32 }

  has_secure_password



  def self.find_by_slug(slug)
    all.detect { |user| user.slug == slug }
  end

  def slug
    @slug ||= username.downcase.split.join('-')
  end



  def invites
    @invites ||= received_invites + sent_invites
  end

  def already_invited?(user)
    invites.detect do |invite|
      invite.sender == user || invite.receiver == user
    end
  end

  def games
    @games ||= games_as_player_1 + games_as_player_2
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
    @opponents ||= games.collect do |game|
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