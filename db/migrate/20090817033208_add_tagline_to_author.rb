class AddTaglineToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :tagline, :string
  end

  def self.down
    remove_column :authors, :tagline
  end
end
