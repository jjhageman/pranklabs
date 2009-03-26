class Comment < ActiveRecord::Base
  belongs_to :user, :counter_cache =>true
  belongs_to :prank, :counter_cache => true
  belongs_to :image, :counter_cache => true
  
  validates_presence_of :body, :user_id
  validates_length_of :body, :maximum => 5000
end
