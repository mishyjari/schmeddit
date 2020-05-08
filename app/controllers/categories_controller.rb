class CategoriesController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.paginate(:page => params[:page], :per_page => 5)
    flash[:category_id] = @category.id
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    category.name = category.name.titleize
    if category.save
      flash[:category_id] = category.id
      redirect_to new_post_path
    else 
      flash[:err] = category.errors.full_messages
      redirect_back fallback_location new_category_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
