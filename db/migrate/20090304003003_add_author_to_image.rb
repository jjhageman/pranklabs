class AddAuthorToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :author_id, :integer
  end

  def self.down
    remove_column :images, :author_id
  end
end
