class AddImagesColumnsToPost < ActiveRecord::Migration
  def self.up
    remove_column :posts, :image
    add_column :posts, :image_file_name, :string
    add_column :posts, :image_content_type, :string
    add_column :posts, :image_file_size, :integer
    add_column :posts, :image_updated_at, :datetime
  end

  def self.down
    add_column :posts, :image, :string
    remove_column :posts, :image_file_name
    remove_column :posts, :image_content_type
    remove_column :posts, :image_file_size
    remove_column :posts, :image_updated_at
  end
end
