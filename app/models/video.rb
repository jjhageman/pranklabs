class Video < ActiveRecord::Base
  belongs_to :prank
  belongs_to :user
  has_many :comments, :order => "created_at", :dependent => :destroy
  
  before_save :validate
  
  VIMEO_RE   = /^http:\/\/(www\.vimeo|vimeo)\.com\/[0-9]*$/
  YOUTUBE_RE = /^http:\/\/(www\.youtube|youtube)\.com\/watch\?v=[^&]*(&.*){0,}$/
  
  def self.video_type(url)
    return YouTube if youtube?(url)
    return Vimeo if vimeo?(url)
    return false
  end
  
  def self.youtube?(url)
    YOUTUBE_RE =~ url
  end

  def self.vimeo?(url)
    VIMEO_RE =~ url
  end
  
  def type
    return YouTube if youtube?
    return Vimeo if vimeo?
    return false
  end
  
  def youtube?
    YOUTUBE_RE =~ video_url
  end

  def vimeo?
    VIMEO_RE =~ video_url
  end
  
  private
  
  def validate
    raise "#{self.class.to_s}#video_url doesn't exist!" unless respond_to?(:video_url)

    unless video_url.blank?
      errors.add_to_base("Video URL has whitespace") if video_url.strip!
      errors.add_to_base("Video URL is not recognized") unless type
    end
  end
end
