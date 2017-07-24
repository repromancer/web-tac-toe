class GamesController < ApplicationController

  get "/games/new" do
    @users = User.all.reject do |user|
      user == current_user
    end.sort_by do |user|
      user.username
    end

    erb :"/games/new.html"
  end

  post "/games" do
    redirect "/games"
  end

  get "/games/:id" do
    @game = Game.find(params[:id])

    if @game.vs_computer?
      # if it's the computer's turn, let it go
      # before displaying the board
    end

    erb :"/games/show.html"
  end

  patch "/games/:id/:cell" do
    unless Game.find(params[:id]).place_token(params[:cell].to_i)
      flash[:message] = "Sorry! That cell is already taken. :("
    end
    redirect "/games/#{params[:id]}"
  end

end
