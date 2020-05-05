class ApplicationController < ActionController::Base
  before_action :set_user 

  def set_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if !@current_user
      redirect_to new_login_path
    end
  end
end
