class CachePrankTagList < ActiveRecord::Migration
  def self.up
    add_column :pranks, :cached_tag_list, :string
  end

  def self.down
    remove_column :pranks, :cached_tag_list
  end
end
