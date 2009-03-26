class RatingStatistic < ActiveRecord::Base
  belongs_to :rated, :polymorphic => true
  belongs_to :rater, :class_name => 'User', :foreign_key => :rater_id
end