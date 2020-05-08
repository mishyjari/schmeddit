class CommentsController < ApplicationController

  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path
    end 

    @errors = flash[:err]
    if params[:parent_comment]
      @parent_comment = Comment.find(params[:parent_comment])
    else
      @parent_post = Post.find(params[:parent_post])
    end

    if @parent_comment || @parent_post
      @comment = Comment.new
    else 
      redirect_to home_path
    end 
  end

  # def create
  #   comment = Comment.new(comment_params)
  #   if comment.parent.class == Post
  #     post = comment.parent
  #   else
  #     parent = Comment.find(params[:comment][:parent_id])
  #     post = parent.find_parent_post || parent
  #   end
  #   if comment.save
  #     redirect_to post_path(post)
  #   else
  #     flash[:err] = comment.errors.full_messages
  #     redirect_back fallback_location: post_path(post)
  #   end
  # end

  def create 
    comment = Comment.new(comment_params)
    if comment.parent_type == 'Post'
      post = comment.parent
    else
      parent = Comment.find(params[:comment][:parent_id])
      post = parent.find_parent_post || parent
    end
    
    if comment.save
      redirect_to post_path(post)
    else
      flash[:err] = comment.errors.full_messages
      @errors = flash[:err]
      redirect_back fallback_location: post_path(post)
    end
  end 

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment.assign_attributes(comment_params)
    if comment.save
      redirect_to comment_path(comment)
    else
      flash[:err] = comment.errors.fulll_messages
      redirect_back fallback_location edit_comment_path(comment)
    end
  end

  def destroy
    post = Post.find(comment_params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :content, :parent_type, :parent_id)
  end
end
