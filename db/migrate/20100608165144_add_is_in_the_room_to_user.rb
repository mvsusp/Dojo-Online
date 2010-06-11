class AddIsInTheRoomToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.references :is_in_the_rooms
      t.remove :room_id
    end
  end

  def self.down
  end
end
