class Prank < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :albums
  has_many :images
  has_many :videos
  has_many :comments, :order => "created_at", :dependent => :destroy
  has_and_belongs_to_many :categories
  acts_as_rated
  acts_as_taggable
  has_friendly_id :title, :use_slug => true
  validates_presence_of :title, :summary, :instructions, :tools
  validates_uniqueness_of :title
  serialize :tools
  
  define_index do
    indexes title
    indexes summary
    indexes tools
    indexes targets
    indexes instructions
    indexes categories.name, :as => :category_name
    indexes tags.name, :as => :tag_name
    indexes user.login, :as => :user_login
  end
  
  def self.featured_prank
    find(54)
  rescue ActiveRecord::RecordNotFound
    first
  end
  
  def self.popular_pranks
    find(:all, :order => 'rating_count DESC', :conditions => "id != #{featured_prank.id}", :limit => 7)
  end
  
  def self.avg_num_votes
    Rating.count.to_f/Prank.count.to_f
  end
  
  def self.avg_rating
    3
  end
  
  def ranking
    ((Prank.avg_num_votes*Prank.avg_rating)+(rating_count*rating_avg))/(Prank.avg_num_votes+rating_count)
  end
  
   def profile_image(type=nil)
     image = primary_image || last_uploaded_image || nil
     case type
     when :big
       image.nil? ? "default_big.png" : image.public_filename(type)
     when :medium
       image.nil? ? "default_medium.png" : image.public_filename(type)
     when :thumb
       image.nil? ? "default_thumb.png" : image.public_filename(type)
     when :medium_square
       image.nil? ? "default_medium_square.png" : image.public_filename(type)
     when :small_square
       image.nil? ? "default_small_square.png" : image.public_filename(type)
     when :tiny_square
       image.nil? ? "default_tiny_square.png" : image.public_filename(type)
     else
       image.nil? ? "default_medium.png" : image.public_filename(type)
     end
   end
  
  def primary_image
   profile_album.images.find_all_by_primary(true).first || false unless profile_album.blank?
  end
  
  def last_uploaded_image
    last_album_image || last_image || false
  end
  
  def profile_album
    albums.find_all_by_profile(true).first
  end
  
  def after_create
    # TODO: is this activated upon every edit?
    albums.create! :title => 'Profile Images', :user_id => user.id, :profile => true
  end
  
  def has_images?
    !images.empty? || !albums_empty?
  end
  
  def albums_empty?
    albums.each do |a|
      return false if !a.images.empty?
    end
    true
  end
  
  def last_album_image
    !albums.blank? ? albums.last.images.last : nil
  end
  
  def last_image
    !images.blank? ? images.last : nil
  end
end
