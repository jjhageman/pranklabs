class TagsController < ApplicationController
  def index
    @tags = Prank.tag_counts
  end

  def show
    @tags = Prank.tag_counts
    @tag = params[:id]
    @tagged_pranks = Prank.find_tagged_with(@tag)
    @pranks = @tagged_pranks.paginate :per_page => 15, :page => params[:page]
  end
end
