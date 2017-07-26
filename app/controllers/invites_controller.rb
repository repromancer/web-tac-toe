class InvitesController < ApplicationController

  post '/invites' do
    Invite.new.tap do |invite|
      invite.sender = current_user
      invite.receiver = User.find(params[:user_id])

      invite.save
    end

    redirect "/users/#{current_user.slug}"
  end

end