class SessionsController < ApplicationController
  
  def new
    render 'login'
  end

  def login
    create
  end

  def create
    if User.find_by(username: params[:username])
      session[:user_id] = User.find_by(username: params[:username]).id
      redirect_back fallback_location: home_path
    else
      flash[:err] = ['User not found with username ' + params[:username]]
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
  end



end
