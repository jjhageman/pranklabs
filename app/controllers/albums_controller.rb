class AlbumsController < ApplicationController
  before_filter :find_prank
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = @prank.albums.find(:all)
    @album_count = @albums.size;
    respond_to do |format|
      format.html {redirect_to prank_album_images_path(@prank, @prank.profile_album) if @prank.albums.count < 2}
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = @prank.albums.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = @prank.albums.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /albums/1/edit
  def edit
    @album = @prank.albums.find(params[:id])
    # @images = @album.images
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = @prank.albums.new(params[:album])
    @album.user = current_user
    @album.profile = false
    respond_to do |format|
      if @album.save
        flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to(prank_album_images_path(@prank, @album)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = @prank.albums.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to(photos_path(@prank)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = @prank.albums.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(prank_albums_path(@prank)) }
    end
  end
  
  private
  
  def find_prank
    @prank_id = params[:prank_id]
    if @prank_id.nil?
      flash[:error] = "No prank specifiedddd #{params[:prank_id]}"
      redirect_to pranks_url
    else
      @prank = Prank.find(@prank_id)
    end
  end
  
  def correct_user_required
    unless album.user == current_user
      flash[:notice] = "You don't have permission to edit that album."
      redirect_to prank_album_path
    end
  end
end
