class ApplicationController < ActionController::Base
  before_action :set_user 

  def title_case(string)
    string.titlecase
  end

  def set_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if !@current_user
      redirect_to login_path
    end
  end
end
