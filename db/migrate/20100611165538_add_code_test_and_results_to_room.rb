class AddCodeTestAndResultsToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :code, :string
    add_column :rooms, :tests, :string
    add_column :rooms, :results, :string
  end

  def self.down
    remove_column :rooms, :results
    remove_column :rooms, :tests
    remove_column :rooms, :code
  end
end
