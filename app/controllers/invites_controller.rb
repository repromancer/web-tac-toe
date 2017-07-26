class InvitesController < ApplicationController

  post '/invites' do
    invited_user = User.find(params[:user_id])

    if current_user.already_invited?(invited_user)
      flash[:message] = "Whoops! Looks like you already have an open invite with that user."
      redirect "/users/#{current_user.slug}"
    else
      Invite.new.tap do |invite|
        invite.sender = current_user
        invite.receiver = invited_user
        invite.save
      end
    end
    redirect "/users/#{current_user.slug}"
  end

  delete '/invites' do
    Invite.find(params[:invite_id]).tap do |invite|
      if invite.sender == current_user
        invite.delete
      end
    end

    redirect "/users/#{current_user.slug}"
  end

  patch '/invites' do
    Invite.find(params[:invite_id]).tap do |invite|
      if invite.receiver == current_user
        invite.ignored = true
        invite.save
      end
    end

    redirect "/users/#{current_user.slug}"
  end

end