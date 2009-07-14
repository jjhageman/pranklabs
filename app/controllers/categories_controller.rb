class CategoriesController < ApplicationController
  
  before_filter :ensure_current_category_url, :only => :show
  
  def index
    @categories = Category.find(:all)
  end

  def show
    redirect_to @category, :status => 301 if @category.has_better_id?
    @remaining_categories = Category.find(:all, :conditions => "id != #{@category.id}")
    @pranks = @category.pranks.paginate :per_page => 15, :order => 'rating_count DESC', :page => params[:page]
  end
  
  private
  
  def ensure_current_category_url
    @category = Category.find(params[:id])
    redirect_to @category, :status => :moved_permanently if @category.has_better_id?
  end
  
end
