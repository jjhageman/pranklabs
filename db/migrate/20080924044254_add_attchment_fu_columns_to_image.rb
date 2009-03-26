class AddAttchmentFuColumnsToImage < ActiveRecord::Migration
  def self.up
    remove_column :images, :url
    add_column :images, :prank_id, :integer
    # the following columns are required for attachment_fu 
    add_column :images, :content_type, :string, :limit => 100 
    add_column :images, :filename, :string, :limit => 255 
    add_column :images, :path, :string, :limit => 255 
    add_column :images, :parent_id, :integer 
    add_column :images, :thumbnail, :string, :limit => 255 
    add_column :images, :size, :integer 
    add_column :images, :width, :integer 
    add_column :images, :height, :integer 
    add_column :pranks, :photos_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :images, :prank_id
    remove_column :images, :content_type
    remove_column :images, :filename
    remove_column :images, :path
    remove_column :images, :parent_id
    remove_column :images, :thumbnail
    remove_column :images, :size
    remove_column :images, :width
    remove_column :images, :height
    remove_column :pranks, :photos_count
    add_column :images, :url, :string, :null => false
  end
end
