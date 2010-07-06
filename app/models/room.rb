class Room < ActiveRecord::Base
  has_many :languages
  has_many :is_in_the_room
  has_many :users, :through => :is_in_the_room

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :languages

  def add_user(user, is_the_owner)
    a = IsInTheRoom.find :all, :conditions => {:room_id => self.id, :user_id => user.id}
    if a.empty? then
        temp = IsInTheRoom.create! :user => user, :room_id => self.id, :owner => is_the_owner
        is_in_the_room << temp
    end
  end

  def remove_user(user)
    a = IsInTheRoom.find :first, :conditions => {:room_id => self.id, :user_id => user.id}
    if !a.nil? then
        a.room.initiated = false if a.owner
        a.room.save
        a.delete
    end
  end

end
