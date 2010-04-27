class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :user_id # este usuario e' o DONO desta sala

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
