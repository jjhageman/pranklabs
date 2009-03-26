class CategoriesController < ApplicationController
  def index
    @categories = Category.find(:all)
  end

  def show
    @category = Category.find(params[:id])
    @remaining_categories = Category.find(:all, :conditions => "id != #{@category.id}")
    @pranks = @category.pranks.paginate :per_page => 15, :page => params[:page]
  end
end
