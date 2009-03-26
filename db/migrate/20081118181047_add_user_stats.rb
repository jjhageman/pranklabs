class AddUserStats < ActiveRecord::Migration
  def self.up
    add_column :users, :pranks_count, :integer, :default => 0, :null => false
    add_column :users, :comments_count, :integer, :default => 0, :null => false
    add_column :users, :albums_count, :integer, :default => 0, :null => false
    
    User.find(:all).each do |u|
      u.pranks_count = u.prank_count
      u.comments_count = u.comments.count
      u.save
    end
  end

  def self.down
    remove_column :users, :pranks_count
    remove_column :users, :comments_count
    remove_column :users, :albums_count
  end
end
