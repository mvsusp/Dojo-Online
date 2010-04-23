class Room < ActiveRecord::Base
  has_many :languages
  belongs_to :user # usuario e' o DONO da sala

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :languages
  validates_presence_of :user
end
