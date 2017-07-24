class GamesController < ApplicationController

  get "/games/new" do
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
