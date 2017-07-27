module GameUtils

  def accepting_invite?(params)
    !!params[:invite_id]
  end

  def start_two_player_game(params)
    invite = Invite.find(params[:invite_id])

    # ensure only recipient can accept invite
    if invite.receiver == current_user
      Game.create.tap do |game|
        game.player_1 = invite.receiver
        game.player_2 = invite.sender
        game.save
        invite.delete
        redirect "/games/#{game.id}"
      end

    else
      # if invalid request, redirect to user profile
      redirect "/users/#{current_user.slug}"
    end

  end

  def start_single_player_game
    Game.create.tap do |game|
      game.player_2 = current_user
      game.save
      redirect "/games/#{game.id}"
    end
  end

  def making_a_move?(params)
    params[:input].is_a?(Hash) &&
    params[:input].has_key?(:cell)
  end

  def process_move(params)
    Game.find(params[:id]).tap do |game|
      if game.current_player == current_user
        unless game.place_token(params[:input][:cell].to_i)
          flash[:message] = "Sorry! That cell is already taken. :("
        end
      end

      redirect "/games/#{params[:id]}"

    end
  end

  def forfeiting_game?(params)
    params[:input] == "forfeit"
  end

  def process_foreiture(params)
    Game.find(params[:id]).tap do |game|

      if game.players.include?(current_user) && ! game.complete?
        game.loser = current_user
        unless game.vs_computer?
          game.winner = game.players.detect{|user| user != current_user}
        end
        game.save
      end

      redirect "/games/#{params[:id]}"

    end
  end

end