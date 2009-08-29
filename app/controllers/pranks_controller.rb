class PranksController < ApplicationController
  before_filter :login_required, :only => [ :edit, :update, :create, :new ]
  before_filter :correct_user_required, :only => [ :edit, :update ], :unless => :admin?
  before_filter :ensure_current_prank_url, :only => :show
  
  
  # GET /pranks
  # GET /pranks.xml
  def index
    @featured_prank = Prank.featured_prank
    @featured_tags = @featured_prank.tag_counts
    @popular_pranks = Prank.popular_pranks
    tag_cloud
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pranks }
    end
  end

  # GET /pranks/1
  # GET /pranks/1.xml
  def show
    redirect_to @prank, :status => 301 if @prank.has_better_id?
    @tags = @prank.tag_counts
    @comments = Comment.find(:all, :conditions => "prank_id = #{@prank.id}", :order => "created_at DESC")
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /pranks/new
  # GET /pranks/new.xml
  def new
    @prank = Prank.new
    @prank.tools = ['']
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /pranks/1/edit
  def edit
    @prank = Prank.find(params[:id])
  end

  # POST /pranks
  # POST /pranks.xml
  def create
    @prank = Prank.new(params[:prank])
    @prank.user = current_user
    @prank.tag_list = params[:tags]
    respond_to do |format|
      if @prank.save
        flash[:notice] = 'Prank was successfully created.'
        format.html { redirect_to(@prank) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pranks/1
  # PUT /pranks/1.xml
  def update
    params[:prank][:category_ids] ||= []
    @prank = Prank.find(params[:id])
    @prank.tag_list = params[:tags]
    respond_to do |format|
      if @prank.update_attributes(params[:prank])
        flash[:notice] = 'Prank was successfully updated.'
        format.html { redirect_to(@prank) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pranks/1
  # DELETE /pranks/1.xml
  def destroy
    @prank = Prank.find(params[:id])
    @prank.destroy

    respond_to do |format|
      format.html { redirect_to(pranks_url) }
    end
  end
  
  def search
    @pranks = Prank.search params[:search], :page => 1, :per_page => 10
  end
  
  def rate_prank
    @prank = Prank.find(params[:id])
    rating = params[:rating].to_i
    @prank.rate rating, current_user
    render :update do |page|
      page.replace_html 'star-ratings', :partial => 'ratings/rating', :object => @prank
    end
  end
  
 private

  def tag_cloud
    @tags = Prank.tag_counts
  end
  
  def correct_user_required
    @prank = Prank.find(params[:id])
    unless @prank.user == current_user
      flash[:notice] = "You don't have permission to edit that prank."
      redirect_to pranks_path
    end
  end

  def ensure_current_prank_url
    @prank = Prank.find(params[:id], :include => {:comments => :user})
    redirect_to @prank, :status => :moved_permanently if @prank.has_better_id?
  end
end
