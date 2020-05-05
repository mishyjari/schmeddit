class PostsController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post.create(post_params)

    if @post.valid?
      redirect_to post_path(@post)
    else
      flash[:err] = @post.errors.full_messages

      redirect_to new_post_path
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)

    if @post.valid?
      redirect_to post_path(@post)
    else
      flash[:err] = @post.errors.full_messages

      redirect_to edit_post_path(@post)      
    end
  end

  def destroy
    @post.destroy

    redirect_to welcome_index_path
  end

  private 

  def post_params(*args)
    params.require(:post).permit(*args)
  end

  def find_user 
    @post = Post.find(params[:id])
  end
end
