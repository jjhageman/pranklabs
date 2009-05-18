class AddVideoIdToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :video_id, :integer
    add_column :videos, :comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :comments, :video_id
  end
end
