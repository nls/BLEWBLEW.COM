class Background < ActiveRecord::Base
  belongs_to :author
  has_attached_file :image
  cattr_reader :per_page
  @@per_page = 5
end
