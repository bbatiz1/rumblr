class User < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 5, maxium: 8}
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end
