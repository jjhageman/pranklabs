class AddPrimaryToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :primary, :boolean
  end

  def self.down
    remove_column :images, :primary
  end
end
