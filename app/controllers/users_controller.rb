class UsersController < ApplicationController

  post "/login" do
    login(params)
  end

  get "/logout" do
    logout
  end

  get "/signup" do
    erb :"/users/new.html"
  end

  post "/signup" do
    signup(params)
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @games = @user.games
    @kd_ratio = if @user.lost_games.any?
      @user.won_games.size.to_f / @user.lost_games.size
    else
      @user.won_games.size
    end.round(1)

    @opponents = @games.collect do |game|
      unless game.vs_computer?
        if game.player_1 == @user
          game.player_2
        else
          game.player_1
        end
      end
    end.uniq.compact

    erb :"/users/show.html"
  end

end
