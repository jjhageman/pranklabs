class Category < ActiveRecord::Base
  has_and_belongs_to_many :pranks
  validates_presence_of :name
end
