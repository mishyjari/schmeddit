class SessionsController < ApplicationController
  
  def new
    if session[:user_id]
      redirect_to user_path(User.find(session[:user_id]))
    else
      render 'login'
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:err] = ['Invalid Credentials!']
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
    redirect_to home_path 
  end



end
