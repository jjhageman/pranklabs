class VideosController < ApplicationController
  before_filter :login_required, :only => [ :edit, :update, :create, :new ]
  before_filter :find_prank
  before_filter :correct_user_required, :only => [ :edit, :update, :destroy ], :unless => :admin?
  
  # GET /videos
  def index
    @videos = @prank.videos.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /videos/1
  def show
    @video = @prank.videos.find(params[:id])
    # @comments = Comment.find(:all, :conditions => "video_id = #{id}", :order => "created_at DESC")
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /videos/new
  def new
    @video = @prank.videos.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /videos/1/edit
  def edit
    @video = @prank.videos.find(params[:id])
  end

  # POST /videos
  def create
    if params[:commit] == "Cancel"
      redirect_to prank_path(@prank) and return
    elsif params[:commit] == "Add"
      @video = vid_model.new(params[:video])
      @video.video_url = vid_model.clean_url(@video.video_url)
      @video.prank = @prank
      @video.user = current_user
      respond_to do |format|
        if @video.save
          flash[:notice] = 'Video was successfully added.'
          format.html { redirect_to prank_videos_path(@prank) }
        else
          flash[:error] = "Error adding video"
          format.html { render :action => "new" }
        end
      end
    end
  end

  # PUT /videos/1
  def update
    @video = @prank.videos.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to prank_video_path(@prank) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /videos/1
  def destroy
    @video = @prank.videos.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
    end
  end
  
  private
  
  def find_prank
    @prank_id = params[:prank_id]
    if @prank_id.nil?
      flash[:error] = "No prank specified"
      redirect_to pranks_path
    else
      @prank = Prank.find(@prank_id)
    end
  end
  
  def correct_user_required
    @video = @prank.videos.find(params[:id])
    unless @video.user == current_user
      flash[:notice] = "You don't have permission to edit that prank."
      redirect_to(prank_video_path(@prank))
    end
  end
  
  # Return the appropriate model corresponding to the type of video.
  def vid_model
    Video.video_type(params[:video][:video_url])
  end
end