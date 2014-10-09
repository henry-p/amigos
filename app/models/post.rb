class Post < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  belongs_to :creator, class_name: "User"
  belongs_to :group
  has_many :comments, as: :commentable

end
