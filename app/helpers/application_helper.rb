# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def title(page_title)
    content_for(:title) { page_title }
  end
  
  # Return a link for use in layout navigation.
  def nav_link(text, controller, action="index", id=nil)
    link_to_unless_current text, :id => nil, :controller => controller, :action => action, :id => id
  end
  
  # Return boolean for admin status
  def admin?
    logged_in? and current_user.admin?
  end
  
  # Return true if logged in user == person
  def current_user?(user)
    logged_in? and user == current_user
  end
  
  def owner?(prank)
    logged_in? and prank.user == current_user
  end
  
  def image_owner?(image)
    logged_in? and image.author == current_user
  end
  
  def album_owner?(album)
    logged_in? and album.user == current_user
  end
  
  def comment_owner?(comment)
    logged_in? and comment.user == current_user
  end
  
  def video_owner?(video)
    logged_in? and video.user == current_user
  end
  
  def current_user_or_admin?(user)
    admin? or current_user?(user)
  end
  
  def owner_or_admin?(prank)
    admin? or owner?(prank)
  end
  
  def image_owner_or_admin?(image)
    admin? or image_owner?(image)
  end
  
  def album_owner_or_admin?(album)
    admin? or album_owner?(album)
  end
  
  def comment_owner_or_admin?(comment)
    admin? or comment_owner?(comment)
  end
  
  def video_owner_or_admin?(video)
    admin? or video_owner?(video)
  end
end