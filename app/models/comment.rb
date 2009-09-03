class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :name, :email, :content, :post_id
  cattr_reader :per_page
  @@per_page = 10
end
