class AddAdditionalCategories < ActiveRecord::Migration
  def self.up
    v = Category.find_by_name('Vehicle')
    v.name = 'Car'
    v.save
    
    Category.create(:name => 'Outdoors')
    Category.create(:name => 'Food')
    Category.create(:name => 'Phone')
    Category.create(:name => 'Public')
  end

  def self.down
    c = Category.find_by_name('Car')
    c.name = 'Vehicle'
    c.save
    
    Category.find(:all, :conditions => { :name => ['Outdoors', 'Food', 'Phone', 'Public'] }).each do |c|
      Category.delete(c.id)
    end
  end
end
