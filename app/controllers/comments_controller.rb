class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    comment = Comment.new(comment_params)
    post = Post.find(comment_params[:post_id]) 
    if comment.save
      redirect_to post_path(post)
    else
      flash[:err] = comment.errors.full_messages
      redirect_back fallback_location: post_path(post)
    end
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
      params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end
