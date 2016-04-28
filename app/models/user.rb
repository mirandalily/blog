class User < ActiveRecord::Base
  has_many :posts
  has_secure_password
  validates_presence_of :username, :email, :password

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug }
  end

end
