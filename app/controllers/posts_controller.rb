class PostsController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :update, :destroy]

  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path
    end 

    @post = Post.new
    @category = Category.find(flash[:category_id]) if flash[:category_id]
    @errors = flash[:err]
  end

  def create
    post = Post.new(post_params)
    post.title = post.title.titleize

    if post.save
      redirect_to post_path(post)
    else
      flash[:err] = post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path
    end 
  end

  def update
    @post.assign_attributes(post_params)
    @post.title = @post.title.titleize
    
    if @post.save
      redirect_to post_path(@post)
    else
      flash[:err] = post.errors.full_messages

      redirect_to edit_post_path(@post)      
    end
  end

  def destroy
    @post.destroy

    redirect_to welcome_index_path
  end

  def up_vote
    post = Post.find(params[:id])
    user_id = session[:user_id]
    post.score += 1
    if UserPostVote.create(user_id: user_id, post_id: post.id, up_vote?: true) && post.save
      redirect_back fallback_location: post_path(post)
    else
      #error
    end
  end

  def down_vote
    post = Post.find(params[:id])
    user_id = session[:user_id]
    post.score -= 1
    if UserPostVote.create(user_id: user_id, post_id: post.id, up_vote?: false) && post.save
      redirect_back fallback_location: post_path(post)
    else
      #error
    end
  end

  def revoke_vote
    post = Post.find(params[:id])
    vote = UserPostVote.find_by(user_id: session[:user_id], post_id: post.id)
    vote.up_vote? ? post.score -= 1 : post.score += 1
    post.save

    vote.destroy
    redirect_back fallback_location: home_path
  end
      
  def favorite
    post = Post.find(params[:id])
    user_id = session[:user_id]
    post.num_favorites += 1
    if UserFavoritePost.create(user_id: user_id, post_id: post.id) && post.save
      redirect_back fallback_location: post_path(post)
    else
      #error
    end
  end

  def un_favorite
    post = Post.find(params[:id])
    post.num_favorites -= 1
    post.save
    fave = UserFavoritePost.find_by(user_id: session[:user_id], post_id: post.id)
    fave.destroy
    redirect_back fallback_location: home_path
  end

  private 

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :content)
  end

  def find_user 
    @post = Post.find(params[:id])
  end
end
