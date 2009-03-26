module AlbumImagesHelper
  def album_image
    return image_tag(@image.public_filename, :class => 'full-pic') if @album.images.length < 2
    link_to(image_tag(@image.public_filename, :class => 'full-pic'), prank_album_image_path(@prank, @album, @album.next_image_loop(@image)) )
  end
  
  def previous_link
    return if @album.images.length < 2
    link_to 'Previous', prank_album_image_path(@prank, @album, @album.previous_image_loop(@image))
  end
  
  def next_link
    return if @album.images.length < 2
    link_to 'Next', prank_album_image_path(@prank, @album, @album.next_image_loop(@image))
  end
end
