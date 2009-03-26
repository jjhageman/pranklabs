class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :url, :null => false
      t.string :caption
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
