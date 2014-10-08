class User < ActiveRecord::Base
  has_one :image, as: :imageable

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
