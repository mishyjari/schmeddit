class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    flash[:category_id] = @category.id
  end

  def create
    category = Category.new(category_params)
    category.name = category.name.titleize
    if category.save
      redirect_to category_path(category)
    else 
      flash[:err] = category.errors.full_messages
      redirect_back fallback_location: new_category_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
