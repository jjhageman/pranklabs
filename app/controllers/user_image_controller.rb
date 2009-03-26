class UserImageController < ApplicationController
  before_filter :login_required, :only => [ :edit, :update, :create, :new ]
  before_filter :find_user
  before_filter :correct_user_required, :only => [ :edit, :update, :create, :new ], :unless => :admin?
  def index
    @image = @user.image
    respond_to do |format|
      format.html
    end
  end

  def show
    @title = !@user.image.blank? ? @user.image.caption : nil
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    #@image = @user.images.find(params[:id])
  end

  def new
    @user.image = Image.new
  end
  
  # POST /user/:user_id/image
  def create
    if params[:commit] == "Cancel"
      redirect_to edit_user_path(@user) and return
    elsif params[:commit] == "Upload"
       #@image = @user.images.new(params[:image].merge(:primary => @user.images.empty?))
       @user.build_image(params[:image].merge(:primary => true))
       respond_to do |format|
         if @user.image.save
           flash[:notice] = "Image successfully uploaded"
           format.html { redirect_to user_image_path(@user, @user.image) }
         else
           flash[:error] = "Error uploading"
           format.html { render :action => "new" }
         end
       end
     end
  end
  
  # PUT /user/1/image/1  
  # PUT /user/1/image/1.xml 
  def update
    if params[:commit] == "Cancel"
      redirect_to edit_user_path(@user) and return
    end
    
    @image = @user.image

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to user_image_path(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    id = params[:id] 
    @image = @user.image.destroy

    respond_to do |format|
      format.html { redirect_to(user_image_path(@user)) }
    end
  end
  
  private
  
  def find_user
    @user_id = params[:user_id]
    if @user_id.nil?
      flash[:error] = "No user specified"
      redirect_to users_url
    else
      @user = User.find(@user_id)
    end
  end
  
  def correct_user_required
    unless @user == current_user
      flash[:notice] = "You don't have permission to edit that user."
      redirect_to users_path
    end
  end
end