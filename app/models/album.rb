class Album < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :prank
  has_many :images
  after_update :save_images
  validates_associated :images
  
  # def profile_image(type=nil)
  #       image = images.find(:first)
  #       case type
  #       when :thumb
  #         image.nil? ? "default_thumbnail.png" : image.public_filename(type)
  #       when :medium
  #          image.nil? ? "default_icon.png" : image.public_filename(type)
  #       when :small
  #          image.nil? ? "default_icon.png" : image.public_filename(type)
  #       when :tiny
  #         image.nil? ? "default_icon.png" : image.public_filename(type)
  #       else
  #         image.nil? ? "default.png" : image.public_filename(type)
  #       end
  #     end
  
  def profile_image(type=nil)
    image = images.find(:first)
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
  
  def image_attributes=(image_attributes)
    image_attributes.each do |attributes|
      image = images.detect { |i| i.id == attributes[:id].to_i }
      image.attributes = attributes
    end
  end
  
  def save_images
    images.each do |i|
      i.save(false)
    end
  end
  
  def next_image(image)
    images.at(images.index(image)+1)
  end
  
  def previous_image(image)
    images.at(images.index(image)-1)
  end
  
  def next_image_loop(image)
    if images.index(image) == images.length-1
      images.first
    else
      next_image(image)
    end
  end
  
  def previous_image_loop(image)
    if images.index(image) == 0
      images.last
    else
      previous_image(image)
    end
  end
end
