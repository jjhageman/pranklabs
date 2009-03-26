class AlbumImagesController < ApplicationController
  before_filter :login_required, :only => [ :edit, :update, :create, :new ]
  before_filter :find_prank
  before_filter :find_album
  before_filter :correct_user_required, :only => [ :edit, :update, :create, :new ], :unless => :admin?
  def index
    @images = @album.images.find(:all)
    @image_count = @images.size
    respond_to do |format|
      format.html
    end
  end
  
  # GET /pranks/1/images1
  # GET /pranks/1/images/1.xml
  def show
    id = params[:id] 
    @image = @album.images.find(id)
    @comments = Comment.find(:all, :conditions => "image_id = #{id}", :order => "created_at DESC")
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @image = @album.images.new
  end
  
  # GET /pranks/:prank_id/images/:id/edit
  def edit
    @image = @album.images.find(params[:id])
  end
  
  # POST /pranks/:prank_id/images 
  def create
    if params[:commit] == "Cancel"
      redirect_to edit_prank_path(@prank) and return
    elsif params[:commit] == "Upload"
      @image = @album.images.new(params[:image].merge(:primary => @prank.has_images?))
      # @image.prank = @prank
      respond_to do |format|
        if @image.save
           flash[:notice] = "Image successfully uploaded"
           format.html { redirect_to prank_album_images_path(@prank, @album) }
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
      redirect_to edit_prank_album_path(@prank, @album) and return
    end
    @image = @album.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to prank_album_image_path(@prank, @album) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /pranks/1/images/1  
  # DELETE /pranks/1/images/1.xml
  def destroy
    id = params[:id] 
    @image = @album.images.find(id).destroy
    respond_to do |format|
      format.html { redirect_to(prank_album_images_path(@prank, @album)) }
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
  
  def find_album
    @album_id = params[:album_id]
    if @album_id.nil?
      @album = nil
      # flash[:error] = "No photo album specified"
      # redirect_to pranks_path
    else
      @album = @prank.albums.find(@album_id)
    end
  end
  
  def correct_user_required
    unless @album.user == current_user
      flash[:notice] = "You don't have permission to edit that prank."
      redirect_to pranks_path
    end
  end
end
