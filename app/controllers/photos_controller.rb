class PhotosController < ApplicationController
  def index
    @prank = Prank.find(params[:id])
    @albums = @prank.albums.find(:all)
    @images = @prank.images.find(:all)
    @photos = @albums + @images
  end

end
