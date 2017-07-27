class GamesController < ApplicationController

  helpers ComputerPlayerLogic, GameUtils



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

    let_computer_play(@game) if @game.computers_turn?

    erb :"/games/show.html"

  end



  patch "/games/:id" do

    if making_a_move?(params)
      process_move(params)
    elsif forfeiting_game?(params)
      process_foreiture(params)
    end

  end

end
