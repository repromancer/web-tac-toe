class GamesController < ApplicationController

  helpers ComputerPlayerLogic


  get "/games/new" do

    @available_users = User.order(:username).select do |user|
      current_user.can_invite?(user)
    end

    erb :"/games/new.html"

  end

  post "/games" do
    invite = Invite.find(params[:invite_id])
    if invite.receiver == current_user
      newgame = Game.create.tap do |game|
        game.player_1 = invite.receiver
        game.player_2 = invite.sender
        game.save
      end
      invite.delete
      redirect "/games/#{newgame.id}"
    else
      redirect "/users/#{current_user.slug}"
    end

  end

  post "/games/singleplayer" do
    newgame = Game.create.tap do |game|
      game.player_2 = current_user
      game.save
    end

    redirect "/games/#{newgame.id}"
  end

  get "/games/:id" do
    @game = Game.find(params[:id])

    if @game.vs_computer? && @game.current_player_token == '1'
      @game.place_token(make_move(@game))
    end

    erb :"/games/show.html"
  end

  patch "/games/:id/forfeit" do
    Game.find(params[:id]).tap do |game|
      unless game.complete?
        game.loser = current_user
        unless game.vs_computer?
          game.winner = game.players.detect{|user| user != current_user}
        end
        game.save
      end
    end

    redirect "/games/#{params[:id]}"
  end

  patch "/games/:id/:cell" do
    Game.find(params[:id]).tap do |game|
      if game.current_player == current_user
        unless game.place_token(params[:cell].to_i)
          flash[:message] = "Sorry! That cell is already taken. :("
        end
      end
    end

    redirect "/games/#{params[:id]}"
  end


end
