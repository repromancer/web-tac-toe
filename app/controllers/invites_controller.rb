class InvitesController < ApplicationController

  post '/invites' do

    invited_user = User.find(params[:user_id])

    if current_user.can_invite?(invited_user)

      Invite.new.tap do |invite|
        invite.sender = current_user
        invite.receiver = invited_user
        invite.save
      end

    else
      flash[:message] = "Whoops! You already <br> have an open game <br> or invite with that user."
    end

    redirect "/users/#{current_user.slug}"

  end



  delete '/invites/:id' do

    Invite.find(params[:id]).tap do |invite|
      if invite.sender == current_user
        invite.delete
      end
    end

    redirect "/users/#{current_user.slug}"

  end



  patch '/invites/:id' do

    Invite.find(params[:id]).tap do |invite|
      if invite.receiver == current_user
        invite.ignored = true
        invite.save
      end
    end

    redirect "/users/#{current_user.slug}"

  end

end