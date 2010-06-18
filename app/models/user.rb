class User < ActiveRecord::Base 
  has_many :is_in_the_room
  has_many :rooms, :through => :is_in_the_room

  validates_presence_of :name
  validates_uniqueness_of :name
end
