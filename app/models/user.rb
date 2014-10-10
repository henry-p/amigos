class User < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  has_one :image, as: :imageable
  has_many :memberships, foreign_key: :member_id
  has_many :groups, through: :memberships
  has_many :managed_groups, foreign_key: :jefe_id, class_name: "Group"
  has_many :posts, foreign_key: :creator_id
  has_many :snippets, foreign_key: :creator_id
  has_many :comments, foreign_key: :creator_id

  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil
  end

  # def authenticate(password)
  #   user = self
  #   return user if user && (user.password == password)
  #   nil
  # end
end