class AddPublishedColumn < ActiveRecord::Migration
  def self.up
    add_column :posts, :visible, :boolean
  end

  def self.down
    remove_column :posts, :visible
  end
end
