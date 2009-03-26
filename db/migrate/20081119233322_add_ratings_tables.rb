class AddRatingsTables < ActiveRecord::Migration
  def self.up
    drop_table :ratings
    ActiveRecord::Base.create_ratings_table
    ActiveRecord::Base.create_ratings_table :with_stats_table => true, :table_name => 'stats_ratings'
    Prank.add_ratings_columns
  end

  def self.down
    Prank.remove_ratings_columns
    ActiveRecord::Base.drop_ratings_table
    ActiveRecord::Base.drop_ratings_table :with_stats_table => true, :table_name => 'stats_ratings'
  end
end
