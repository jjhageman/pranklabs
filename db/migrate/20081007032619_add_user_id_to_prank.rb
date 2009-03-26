class AddUserIdToPrank < ActiveRecord::Migration
  def self.up
    add_column :pranks, :user_id, :integer
  end

  def self.down
    remove_column :pranks, :user_id
  end
end
