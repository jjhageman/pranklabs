class CreatePranks < ActiveRecord::Migration
  def self.up
    create_table :pranks do |t|
      t.string :title
      t.text :summary
      t.text :tools
      t.text :targets
      t.text :instructions

      t.timestamps
    end
  end

  def self.down
    drop_table :pranks
  end
end
