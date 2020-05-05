class SessionsController < ApplicationController
  
  def new
    render 'login'
  end

  def create
    if User.find(params[username: username])
      session[:user] = User.find(params[username:username])
      redirect_back fallback_location: home_path
    else
      flash[:err] = 'User not found with username ' + params[username]
      redirect_to login_path
    end
  end

  def destroy
  end

end
