class CreateIsInTheRooms < ActiveRecord::Migration
  def self.up
    create_table :is_in_the_rooms do |t|
      t.references :room
      t.references :user
      t.boolean :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :is_in_the_rooms
  end
end
