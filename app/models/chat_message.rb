class ChatMessage < ActiveRecord::Base
  validates_presence_of :poster, :message
  belongs_to :room
end
