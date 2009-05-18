class AddTypeToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :type, :string
  end

  def self.down
    remove_column :videos, :type
  end
end
