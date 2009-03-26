class AddCommentStatsToImagesPranks < ActiveRecord::Migration
  def self.up
    add_column :pranks, :comments_count, :integer, :default => 0, :null => false
    add_column :images, :comments_count, :integer, :default => 0, :null => false
    
    Prank.find(:all).each do |p|
      p.comments_count = p.comments.count
      p.save
    end
    
    Image.find(:all).each do |i|
      i.comments_count = i.comments.count
      i.save
    end
  end

  def self.down
    remove_column :pranks, :comments_count
    remove_column :images, :comments_count
  end
end
