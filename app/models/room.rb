class Room < ActiveRecord::Base
  has_many :languages
  has_many :is_in_the_room
  has_many :users, :through => :is_in_the_room

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :languages

  def add_user (user, owner)
    temp = IsInTheRoom.create! :user => user, :room_id => @id, :owner => owner
    is_in_the_room << temp
  end
end
