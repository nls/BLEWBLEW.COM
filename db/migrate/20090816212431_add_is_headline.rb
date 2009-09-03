class AddIsHeadline < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_headline, :boolean
  end

  def self.down
    remove_column :posts, :is_headline
  end
end
