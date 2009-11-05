class UsersController < ApplicationController
  
  before_filter :login_required, :only => [ :edit, :update, ]
  before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :correct_user_required, :only => [ :edit, :update ], :unless => :admin?
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)
    @most_pranks = User.find(:all, :conditions => 'pranks_count > 0', :order => 'pranks_count DESC', :limit => 5)
    @most_albums = User.find(:all, :conditions => 'albums_count > 0', :order => 'albums_count DESC', :limit => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @images = Image.find_all_by_author_id(@user.id)
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # GET /user/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.enabled = true
    @user.admin = false
    @user.register! if @user.valid?
    respond_to do |format|
      @user.save
      if @user.errors.empty?
        #self.current_user = @user #comment out force user to activate first
        flash[:notice] = "To complete your registration, check your email for an activation code."
        format.html #{ redirect_back_or_default(login_path) }
      else
        flash.now[:error] = "Error signing up"
        format.html { render :action => 'new' }
      end
    end
  end
  
  # PUT /users/1 
  # PUT /users/1.xml 
  def update 
    @user = User.find(params[:id]) 
    respond_to do |format| 
      if @user.update_attributes(params[:user]) 
        flash[:notice] = "User #{@user.login} was successfully updated." 
        format.html { redirect_to(:action=>:show) } 
      else 
        format.html { render :action => "edit" } 
      end 
    end 
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate!
      flash[:notice] = "Signup complete!"
    else
      flash[:notice] = "Couldn't find your activation code #{params[:activation_code]}"
    end
    redirect_back_or_default(pranks_path)
  end
  
  def suspend
    @user.suspend! 
    redirect_to users_path
  end
  
  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end
  
  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    begin
      flash[:notice] = "User #{@user.login} deleted"
      # @user.destroy
      @user.delete!
    rescue
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(users_path) }
    end
  end
  
  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:user][:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default(login_path)
      flash[:notice] = "A password reset message has been sent to your email address"
    else
      flash[:error] = "Could not find a user with that email address"
    end
  end
  
  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]

        if current_user.save
          flash[:notice] = "Password successfully updated" 
          redirect_to profile_url(current_user.login)
        else
          flash[:error] = "Password not changed" 
        end

      else
        flash[:error] = "New Password mismatch" 
        @old_password = params[:old_password]
      end
    else
      flash[:error] = "Old password incorrect" 
    end
  end
  
  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]) && !params[:user][:password_confirmation].blank?)
      self.current_user = @user #for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Password reset success." : "Password reset failed." 
      redirect_back_or_default('/')
    else
      flash[:error] = "Password mismatch" 
    end  
  end
  
 private
  def find_user
    @user = User.find(params[:id])
  end
  
  def admin_required
    redirect_to users_path unless admin?
  end
  
  def correct_user_required
    redirect_to users_path unless User.find(params[:id]) == current_user
  end

end
