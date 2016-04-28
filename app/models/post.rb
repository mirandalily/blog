class Post < ActiveRecord::Base

  belongs_to :user
  has_many :post_tags
  has_many :tag, :through => :post_tags

end
