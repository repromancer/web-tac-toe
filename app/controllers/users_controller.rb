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


    erb :"/users/show.html"
  end

end
