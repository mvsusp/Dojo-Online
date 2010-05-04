class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :user_id     # this user is the OWNER of this room
      t.boolean :initiated   # true if this room is initiated, false otherwise

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
