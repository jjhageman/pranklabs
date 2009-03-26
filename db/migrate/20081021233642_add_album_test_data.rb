class AddAlbumTestData < ActiveRecord::Migration
  def self.up
     Album.delete_all
     Album.create(:title => 'Profile Images', :prank_id => 2, :user_id => 1, :profile => true)
     Album.create(:title => 'Profile Images', :prank_id => 3, :user_id => 1, :profile => true)
     Album.create(:title => 'Profile Images', :prank_id => 4, :user_id => 4, :profile => true)
     Album.create(:title => 'Profile Images', :prank_id => 5, :user_id => 2, :profile => true)
     Album.create(:title => 'Profile Images', :prank_id => 6, :user_id => 3, :profile => true)
     Album.create(:title => 'Profile Images', :prank_id => 7, :user_id => 2, :profile => true)
     
     Image.update(10, {:album_id => 1})
     Image.update(16, {:album_id => 2})
     Image.update(22, {:album_id => 3})
     Image.update(25, {:album_id => 3})
     Image.update(28, {:album_id => 4})
     Image.update(31, {:user_id => 2})
     Image.update(34, {:album_id => 1})
  end

  def self.down
    Album.delete_all
    Image.update(10, {:album_id => nil})
    Image.update(16, {:album_id => nil})
    Image.update(22, {:album_id => nil})
    Image.update(25, {:album_id => nil})
    Image.update(28, {:album_id => nil})
    Image.update(31, {:user_id => nil})
    Image.update(34, {:album_id => nil})
  end
end
