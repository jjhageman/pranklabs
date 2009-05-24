class Image < ActiveRecord::Base
  UPLOAD_LIMIT = 1 # megabytes
  belongs_to :user
  belongs_to :album
  belongs_to :prank
  has_many :comments, :order => "created_at", :dependent => :destroy
  #has_attached_file :avatar, :styles => { :main => '500', :medium => '130x130#', :small => '75x75#', :tiny => '48x48#' }
  has_attachment  :content_type => :image,
                  :storage => :file_system,
                  :path_prefix => 'public/shared/images',
                  :resize_to => '640x640',
                  :thumbnails => { :big => '560x560', :medium => '240x240', :thumb => '100x100', :medium_square => '130x130!', :small_square => '75x75!', :tiny_square => '48x48!'},
                  :max_size => UPLOAD_LIMIT.megabytes,
                  :min_size => 1,
                  :content_type => :image,
                  :processor => 'MiniMagick'
  validates_as_attachment
  
  def author
    User.find(author_id)
  end
end
