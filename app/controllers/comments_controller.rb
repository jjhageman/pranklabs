class CommentsController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :destroy ]
  before_filter :initialize_variables, :only => [ :new, :create, :destroy ]
  before_filter :authorize_destroy, :only => [:destroy]

  # GET /comments
  # GET /comments.xml
  def index
   redirect_to pranks_url
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    redirect_to pranks_url
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    # puts "parent: " + parent.id.to_s
    # puts "resource: " + resource
    @comment = parent.comments.new
    @resource = resource
    render :update do |page|
      page.hide "new_comment_link", "new_comment_form"
      page.replace_html "new_comment_form", :partial => "#{@resource}/new_comment_form"
      page[:new_comment_form].visual_effect :blind_down
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = parent.comments.new(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        flash.now[:notice] = 'Your comment was successfully created.'
        format.html { redirect_to(parent) }
        format.js {
          @resource = resource
          @count = parent.comments.count
        }
      else
        flash.now[:error] = "Error saving comment"
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = parent.comments.find(params[:id])
    @comment.destroy
    @count = parent.comments.count
    render :update do |page|
      page.replace_html 'comment-count', :partial => 'comment_count', :locals => { :count => @count }
      page.visual_effect :blind_up, "comment_#{@comment.id}"
      #page.remove "comment_#{@comment.id}"
    end
  end
  
  private
  
  def initialize_variables
    find_prank
    if album?
      find_album
      @image = @album.images.find(params[:image_id])
    elsif image?
      @image = @prank.images.find(params[:image_id])
    end
  end
  
  def find_prank
    @prank_id = params[:prank_id]
    if @prank_id.nil?
      flash.now[:error] = "No prank specified"
      redirect_to pranks_url
    else
      @prank = Prank.find(@prank_id)
    end
  end
  
  def find_album
    @album_id = params[:album_id]
    if @album_id.nil?
      flash.now[:error] = "No photo album specified"
      redirect_to pranks_path
    else
      @album = @prank.albums.find(@album_id)
    end
  end
  
  def authorized_to_destroy?
    @comment = parent.comments.find(params[:id])
    current_user == @comment.user
  end
  
  def authorize_destroy
    redirect_to pranks_url unless authorized_to_destroy?
  end
  
  def parent
    if image?
      @image
    elsif prank?
      @prank
    end
  end
  
  # Return the URL for the resource comments.
  def comments_url
    if image?
      prank_album_image_path(@prank, @album)
    elsif prank?
      @prank
    end
  end
  
  # Return a string of the view folder.
  def resource
    if album?
      "album_images"
    elsif image?
      "prank_images"
    elsif prank?
      "pranks"
    end
  end
  
  # True if resource is only a prank
  def prank?
    !params[:prank_id].nil?
  end
  
  # True if resource belongs to an album
  def album?
    !params[:album_id].nil?
  end

  # True if resource only an image directly within a prank.
  def image?
    !params[:image_id].nil?
  end
end
