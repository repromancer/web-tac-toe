class GamesController < ApplicationController

  helpers ComputerPlayerLogic, GameUtils



  get "/games/new" do

    @available_users = User.order(:username).select do |user|
      current_user.can_invite?(user)
    end

    erb :"/games/new.html"

  end



  post "/games" do

    if accepting_invite?(params)
      start_two_player_game(params)
    else
      start_single_player_game
    end

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
