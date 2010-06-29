class AddCodeTestAndResultsToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :code, :text
    add_column :rooms, :tests, :text
    add_column :rooms, :results, :text
  end

  def self.down
    remove_column :rooms, :results
    remove_column :rooms, :tests
    remove_column :rooms, :code
  end
end
