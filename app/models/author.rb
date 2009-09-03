class Author < ActiveRecord::Base
  has_many :posts
  has_many :backgrounds
  has_attached_file :image,
                    :styles => {
                      :thumb => "200x200>"
                    }
  def self.authenticate(user, password)
    user = self.find_by_user(user)
    if user
      if user.password != password
        user = nil
      end
    end
    user
  end
end
