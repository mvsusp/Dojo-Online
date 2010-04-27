class User < ActiveRecord::Base
  has_one :room

  validates_presence_of :name
  validates_uniqueness_of :name
end
