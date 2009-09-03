class Post < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  has_attached_file :image,
                    :styles => { :topheadline => "450x200#",
                              :subheadline =>"350x90#",
                              :inpost => "400x400>"}
  cattr_reader :per_page
  @@per_page = 5
end
