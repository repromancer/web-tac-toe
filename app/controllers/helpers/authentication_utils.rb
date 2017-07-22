module AuthenticationUtils

  def current_user
    if defined?(@current_user)
      @current_user
    elsif session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def login(params)

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome, #{user.username}!"
      yield if block_given?
    else
      flash[:message] = "Sorry. Incorrect login information."
      redirect '/'
    end

  end

  def logged_in?
    !!current_user
  end

  def screen_unauthorized_users
    unless logged_in?
      flash[:message] = "Please log in."
      redirect '/'
    end
  end

  def logout
    session.clear
  end

  def signup(params)
    User.new.tap do |user|
      user.username = params[:username]
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]

      if user.save
        login(params){yield if block_given?}
      else
        flash[:message] = "Please fill out every field."
        redirect '/signup'
      end

    end
  end

end