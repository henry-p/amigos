class Post < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  belongs_to :creator, class_name: "User"
  belongs_to :group
  has_many :comments, as: :commentable
<<<<<<< HEAD

=======
  has_many :images, as: :imageable
>>>>>>> 23113cd40b68b29f2e994019330fac556d1b05c8
end
