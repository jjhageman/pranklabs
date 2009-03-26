class AddUserStates < ActiveRecord::Migration
  def self.up 
    User.find(:all).each do |user| 
      User.update(user.id, {:state => 'active'})
    end
  end

  def self.down
  end
end
