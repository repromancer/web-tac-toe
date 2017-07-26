class InvitesController < ApplicationController

  post '/invites' do
    Invite.new.tap do |invite|
      invite.sender = current_user
      invite.receiver = User.find(params[:user_id])

      invite.save
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
end