class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.integer :prank_id
      t.integer :user_id
      t.boolean :profile

      t.timestamps
    end
    add_column :images, :album_id, :integer
  end

  def self.down
    drop_table :albums
    remove_column :images, :album_id
  end
end
