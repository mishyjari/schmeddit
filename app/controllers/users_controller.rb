class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.first_name = user.first_name.titleize
    user.last_name = user.last_name.titleize

    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:err] = user.errors.full_messages

      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
  end

  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:err] = user.errors.full_messages
      redirect_to edit_user_path(user)
    end
  end 

  def destroy
    @user.destroy

    redirect_to welcome_index_path
  end

  def favorites
    @user = User.find(params[:id])
    render 'favorites'
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.order({ created_at: :desc })
    render 'posts'
  end

  private 

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :profile_img_url, :bio, :password)
  end

  def find_user 
    @user = User.find(params[:id])
  end
end
