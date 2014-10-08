class Post < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :group
end
