class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.text :name
      t.text :description
      t.integer :user_id     # this user is the OWNER of this room
      t.boolean :initiated   # true if this room is initiated, false otherwise

      t.text :source_code
      t.text :test_code
      t.text :code_result

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
