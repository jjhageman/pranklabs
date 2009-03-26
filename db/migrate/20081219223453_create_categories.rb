class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    Category.delete_all
    Category.create(:name => 'Office')
    Category.create(:name => 'Dorm')
    Category.create(:name => 'Home')
    Category.create(:name => 'School')
    Category.create(:name => 'Vehicle')
    Category.create(:name => 'Computer')
    
    create_table :categories_pranks, :id => false do |t|
      t.integer :category_id
      t.integer :prank_id
    end
  end

  def self.down
    drop_table :categories
  end
end
