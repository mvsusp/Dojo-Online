class CreateChatMessages < ActiveRecord::Migration
  def self.up
    create_table :chat_messages do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :chat_messages
  end
end
