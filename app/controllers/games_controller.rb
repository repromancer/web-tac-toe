class GamesController < ApplicationController

  helpers ComputerPlayerLogic

  get "/games/new" do
    @users = User.all.reject do |user|
      user == current_user
    end.sort_by do |user|
      user.username
    end

    erb :"/games/new.html"
  end

  post "/games" do
    invite = Invite.find(params[:invite_id])
    if invite.receiver == current_user
      newgame = Game.create.tap do |game|
        game.players << invite.sender
        game.players << invite.receiver
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
      game.players << current_user
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
    unless Game.find(params[:id]).place_token(params[:cell].to_i)
      flash[:message] = "Sorry! That cell is already taken. :("
    end
    redirect "/games/#{params[:id]}"
  end


end
