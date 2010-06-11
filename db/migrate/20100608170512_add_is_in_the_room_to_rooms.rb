class AddIsInTheRoomToRooms < ActiveRecord::Migration
  def self.up
    change_table :rooms do |t|
      t.references :is_in_the_rooms
      t.remove :user_id
    end
  end

  def self.down
  end
end
