class AddImageToAuthor < ActiveRecord::Migration
  def self.up
    remove_column :authors, :image
    add_column :authors, :image_file_name, :string
    add_column :authors, :image_content_type, :string
    add_column :authors, :image_file_size, :integer
    add_column :authors, :image_updated_at, :datetime
  end

  def self.down
    add_column :authors, :image, :string
    remove_column :authors, :image_file_name
    remove_column :authors, :image_content_type
    remove_column :authors, :image_file_size
    remove_column :authors, :image_updated_at
  end
end
