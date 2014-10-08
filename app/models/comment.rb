class Comment < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  belongs_to :commentable, polymorphic: true
end
