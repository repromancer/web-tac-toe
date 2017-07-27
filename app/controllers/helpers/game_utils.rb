module GameUtils

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