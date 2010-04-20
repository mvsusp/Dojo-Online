class Room < ActiveRecord::Base
  has_many :languages
  #has_one :user

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :languages
  #validates_presence_of :user_id # dono da sala
end
