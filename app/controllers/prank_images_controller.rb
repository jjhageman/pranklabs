class PrankImagesController < ApplicationController
  before_filter :login_required, :only => [ :edit, :update, :create, :new ]
  before_filter :find_prank
  before_filter :correct_user_required, :only => [ :edit, :update, :destroy ], :unless => :admin?
  def index
    @images = @prank.images.find(:all)
    @image_count = @images.size
    respond_to do |format|
      format.html
    end
  end
  
  # GET /pranks/1/images1
  # GET /pranks/1/images/1.xml
  def show
    id = params[:id] 
    @image = @prank.images.find(id)
    @comments = Comment.find(:all, :conditions => "image_id = #{id}", :order => "created_at DESC")
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @image = @prank.images.new
  end
  
  # GET /pranks/:prank_id/images/:id/edit
  def edit
    @image = @prank.images.find(params[:id])
  end
  
  # POST /pranks/:prank_id/images 
  def create
    if params[:commit] == "Cancel"
      redirect_to edit_prank_path(@prank) and return
    elsif params[:commit] == "Upload"
      @image = @prank.images.new(params[:image].merge(:primary => @prank.has_images?, :author_id => current_user.id))
      respond_to do |format|
         # if @prank.images << @image
         if @image.save
           flash[:notice] = "Image successfully uploaded"
           format.html { redirect_to photos_path(@prank) }
         else
           flash[:error] = "Error uploading"
           format.html { render :action => "new" }
         end
       end
     end
  end
  
  # PUT /pranks/1/images/1  
  # PUT /pranks/1/images/1.xml 
  def update
    if params[:commit] == "Cancel"
      redirect_to edit_prank_path(@prank) and return
    end
    @image = @prank.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to prank_image_path(@prank) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /pranks/1/images/1  
  # DELETE /pranks/1/images/1.xml
  def destroy
    id = params[:id] 
    @image = @prank.images.find(id).destroy
    respond_to do |format|
      format.html { redirect_to(prank_images_path(@prank)) }
    end
  end
  
  private
  
  def find_prank
    @prank_id = params[:prank_id]
    if @prank_id.nil?
      flash[:error] = "No prank specified"
      redirect_to pranks_url
    else
      @prank = Prank.find(@prank_id)
    end
  end
  
  def correct_user_required
    @image = @prank.images.find(params[:id])
    unless @image.user == current_user or @image.author == current_user
      flash[:notice] = "You don't have permission to edit that prank."
      redirect_to(photos_path(@prank))
    end
  end
end
