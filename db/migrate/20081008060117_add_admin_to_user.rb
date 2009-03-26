class AddAdminToUser < ActiveRecord::Migration
  
  class User < ActiveRecord::Base  
  end
  
  def self.up
    add_column :users, :admin, :boolean, :default => false, :null => false
    add_column :users, :enabled, :boolean, :default => true, :null => false
    
    user = User.new(:email => "admin@example.com",
                        :login => "admin",
                        :activated_at => Time.now)
    salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{user.login}--")
    user.crypted_password = Digest::SHA1.hexdigest("--#{salt}--admin--")
    user.admin = true
    user.save!
  end

  def self.down
    remove_column :users, :enabled
    User.delete(User.find_by_name("admin"))
    remove_column :users, :admin
  end
end
