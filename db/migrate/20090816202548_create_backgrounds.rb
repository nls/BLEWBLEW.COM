class CreateBackgrounds < ActiveRecord::Migration
  def self.up
    create_table :backgrounds do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :backgrounds
  end
end
